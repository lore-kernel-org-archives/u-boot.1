Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5062D111A5
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 05:01:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39D8988EAF;
	Mon,  4 Nov 2024 06:01:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="EV2zT4jp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B7EB88ED9; Mon,  4 Nov 2024 06:01:31 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B5A888E63
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 06:01:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4A451PU3094362;
 Sun, 3 Nov 2024 23:01:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1730696485;
 bh=YMwpB/mGJZfzl8F9fsaDK+emRjv4eirZVgaFVJYhJGg=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=EV2zT4jpeMb9bIZQXQPU8FHWEKn4Ajy/rgkJzJzO7L0Hk7uPdJUfxNIA5bt9NMUf7
 FqvXekKrNZNGYxaJAcI9IgCc3bF3coq+EekARUsACvu8eM6V+ahdOQu9TcMoDK2fUq
 Mu4WhUAcEVkxXQeF9QzDNGpqb8prJGqI/4I+eOlI=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A451PBg045786;
 Sun, 3 Nov 2024 23:01:25 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 3
 Nov 2024 23:01:25 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 3 Nov 2024 23:01:25 -0600
Received: from [172.24.227.36]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36]
 (may be forged))
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A451NNo101286;
 Sun, 3 Nov 2024 23:01:24 -0600
Message-ID: <f7ab94a0-c782-45e3-9046-c87f22848ba5@ti.com>
Date: Mon, 4 Nov 2024 10:31:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] cmd: upl: initialize unit test state
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Simon Glass
 <sjg@chromium.org>
CC: <u-boot@lists.denx.de>
References: <20241102143020.129450-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20241102143020.129450-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Hi Heinrich

On 02/11/24 20:00, Heinrich Schuchardt wrote:
> do_upl_write() calls upl_get_test_data() which may increment the fail
> count in the unit test state. We should initialize it.
> 
> Addresses-Coverity-ID: 510465 Uninitialized scalar variable
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>   cmd/upl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/cmd/upl.c b/cmd/upl.c
> index 4996f36c787..c9a823bbc06 100644
> --- a/cmd/upl.c
> +++ b/cmd/upl.c
> @@ -50,7 +50,7 @@ static int do_upl_write(struct cmd_tbl *cmdtp, int flag, int argc,
>   			char *const argv[])
>   {
>   	struct upl s_upl, *upl = &s_upl;
> -	struct unit_test_state uts;
> +	struct unit_test_state uts = { 0 };
>   	struct abuf buf;
>   	oftree tree;
>   	ulong addr;

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis
