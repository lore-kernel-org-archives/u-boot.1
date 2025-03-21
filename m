Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A71C36000
	for <u-boot@archiver.kernel.org>; Fri, 21 Mar 2025 19:23:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CA618082A;
	Fri, 21 Mar 2025 20:23:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742584985;
	bh=xwEBzad26flTcXLFD2OFHURPM8J5indOZbchA9+HnYk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hzrNxUFfaz5AVqSnmoWbZ39IfA7aEUoCTi6zIJ7ywGX37MLMWGWIzBt2wMS+xHnvq
	 rf6JwnrSF3ncwHL/zc9eb+n2OVJ+6dwyJkWxO+Zd6EKwRmVrSlodhcvfGPJjmm5tDw
	 htGd4rNR3E7oOFNe5IUsWlTfV3oTAamd1QKXP0AGD+XlfWpVX1t5OYK2jOZlnhkJ7g
	 K4fD7t4pRLAr0fZLuogJhSfeVVYUo3Hc/cC7MMj2S/9uVuV+o6IpJDp9mqqkcqNFxC
	 wSeXdNHMK+prKHfaUKMjykIPgz1+jJkAKhk7x/Qt+l8abwsqs5nfxDGSvkxiep+rBV
	 PazAzaYdSIX+A==
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6FD4808A2; Fri, 21 Mar 2025 20:23:03 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C695B806D8
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 20:23:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="HTLHOsXk"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D089510206773; Fri, 21 Mar 2025 20:22:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742584980; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=xwEBzad26flTcXLFD2OFHURPM8J5indOZbchA9+HnYk=;
 b=HTLHOsXkZuaDssaXpnDRIXrt1cgTSV1h1HfAWM+PL1qczrg4hE9uEBdjRd8pI6TWjGehLa
 8j228dGKrrim70tA5rnLL+dG7aq/2wm1E5DLJ45McEWG6o+hwq+hcJuNwrVwFrmlG2egqn
 xLNbzihxcCMgpTMARxonwDqp5/dfZtW9FOsYEZYWIyvT72E+c4CbpxLw6i4Hr+D4z57YAS
 4NU0ap4DqJpGKWrEb1P/8QQ/aFGvKfgftPmTcSlpmNCNiW2KzFR3jWbquYj3vJSzNCQNiQ
 Bp/jg84i0vHx5ahCO/BrG4Szdyb1SQGdOdmnknlLZnkStCHxe8qtIsiBAUssRg==
Message-ID: <1fac6372-b251-4778-b3fe-7f7eda3aac8f@denx.de>
Date: Fri, 21 Mar 2025 20:22:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] cmd: env: select: Add output for available evironment
 targets
To: Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>
References: <20250321184357.4079845-1-cniedermaier@dh-electronics.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250321184357.4079845-1-cniedermaier@dh-electronics.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 3/21/25 7:43 PM, Christoph Niedermaier wrote:
> Add parameter "-l" for printing available environment targets. The
> active target is marked with an asterisk. This is done by adding
> the function env_select_print_list().
> 
> If "env select" is called without a target parameter the result is
> "Select Environment on <NULL>: driver not found". Replace this not
> so useful output by showing the env usage message instead.
> 
> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> ---
> Cc: Marek Vasut <marex@denx.de>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Joe Hershberger <joe.hershberger@ni.com>
> Cc: Tom Rini <trini@konsulko.com>
> ---
> V2: - Showing available environment targets by parameter "-l"
>      - Showing env usage message if env select is called without a target
> ---
>   cmd/nvedit.c  | 19 ++++++++++++++++++-
>   env/env.c     | 16 ++++++++++++++++
>   include/env.h |  7 +++++++
>   3 files changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/cmd/nvedit.c b/cmd/nvedit.c
> index 1f259801293..de64094db4d 100644
> --- a/cmd/nvedit.c
> +++ b/cmd/nvedit.c
> @@ -499,6 +499,23 @@ static int do_env_load(struct cmd_tbl *cmdtp, int flag, int argc,
>   static int do_env_select(struct cmd_tbl *cmdtp, int flag, int argc,
>   			 char *const argv[])
>   {
> +	if (!argv[1])
> +		return CMD_RET_USAGE;
> +
> +	while (argc > 1 && **(argv + 1) == '-') {
Two higher level things:

- Can you first convert cmd/nvedit.h to use include/getopt.h and then
   use getopt() here too ? This hand rolled arg parsing is repulsive,
   the multiple ad-hoc copies of that are even worse.
- Please write a test for this, see test/cmd/ , maybe Simon can help
   with details of this ... ?
