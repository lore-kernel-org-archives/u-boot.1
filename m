Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19816D68BEB
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 08:21:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CFAB83C2B;
	Thu, 18 Dec 2025 09:21:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E22C83CAA; Thu, 18 Dec 2025 09:21:15 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 4475D83C28
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 09:21:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 594A5FEC;
 Thu, 18 Dec 2025 00:21:05 -0800 (PST)
Received: from debian (MacBookPro.nice.arm.com [10.34.124.17])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 461C33F5CA;
 Thu, 18 Dec 2025 00:21:11 -0800 (PST)
Date: Thu, 18 Dec 2025 09:21:07 +0100
From: Vincent =?utf-8?Q?Stehl=C3=A9?= <vincent.stehle@arm.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrick Delaunay <patrick.delaunay@st.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] cmd: nvedit: Validate argument count before use
Message-ID: <aUO5c2lv2Au1B1Qt@debian>
Mail-Followup-To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrick Delaunay <patrick.delaunay@st.com>,
 Tom Rini <trini@konsulko.com>
References: <20251217195811.754518-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251217195811.754518-1-marek.vasut+renesas@mailbox.org>
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Wed, Dec 17, 2025 at 08:57:38PM +0100, Marek Vasut wrote:
> Avoid NULL pointer dereference in case 'env select' is invoked
> without parameters, check the arg count and make sure it is at
> least 2, otherwise print usage.
> 
> The crash is easy to trigger e.g. in sandbox:
> $ ./u-boot -Tc "env select"

Thanks Marek.

I confirm this patch does indeed fix the crash on sandbox.
The behaviour remains the same when selecting "nowhere".
Feel free to add (or not):

  Tested-by: Vincent Stehlé <vincent.stehle@arm.com>

Best regards,
Vincent.

> 
> Fixes: a97d22ebba23 ("cmd: env: add env select command")
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Patrick Delaunay <patrick.delaunay@st.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Vincent Stehlé <vincent.stehle@arm.com>
> Cc: u-boot@lists.denx.de
> ---
>  cmd/nvedit.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/cmd/nvedit.c b/cmd/nvedit.c
> index 11c3cea882b..636bddee1be 100644
> --- a/cmd/nvedit.c
> +++ b/cmd/nvedit.c
> @@ -499,6 +499,9 @@ static int do_env_load(struct cmd_tbl *cmdtp, int flag, int argc,
>  static int do_env_select(struct cmd_tbl *cmdtp, int flag, int argc,
>  			 char *const argv[])
>  {
> +	if (argc < 2)
> +		return CMD_RET_USAGE;
> +
>  	return env_select(argv[1]) ? 1 : 0;
>  }
>  #endif
> -- 
> 2.51.0
> 
