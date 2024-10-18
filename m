Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF7CD3C545
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 03:23:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F40D89093;
	Fri, 18 Oct 2024 05:23:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="a71bqyup";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 835868910E; Fri, 18 Oct 2024 05:23:08 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7453889093
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 05:23:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49I3N1ZU012112;
 Thu, 17 Oct 2024 22:23:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1729221781;
 bh=0rDAK+0YFC4ChyNaBcf6kygMf0kAXug9ApSJlm+h8Cs=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=a71bqyupd9Vke4b6tLaBLnu6B5RCnW0ZtbPCHOOARahgSNs274g/+++qQWAFYk2tr
 pyFjy6R9Ps1fFto/RFonG/mViPW+51sN8q11Q4MwiiGN0KdfhSsS2rn4bFD1c4rozD
 l7leHj2ypE7tyldgsqhLPC/4JRyQETrkTmcMpb/E=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49I3N18W122531
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 17 Oct 2024 22:23:01 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 17
 Oct 2024 22:23:01 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 17 Oct 2024 22:23:01 -0500
Received: from [172.24.227.36]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36]
 (may be forged))
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49I3MxfN102255;
 Thu, 17 Oct 2024 22:23:00 -0500
Message-ID: <c791766b-e263-4913-829b-c4586cd256e6@ti.com>
Date: Fri, 18 Oct 2024 08:52:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] cmd: upl: correct printf code
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Simon Glass
 <sjg@chromium.org>
CC: <u-boot@lists.denx.de>
References: <20241018024657.134492-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20241018024657.134492-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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

On 18/10/24 08:16, Heinrich Schuchardt wrote:
> Building on 32-bit results in a build failure:
> 
>      cmd/upl.c:75:51: warning: format ‘%lx’ expects argument of type
>      ‘long unsigned int’, but argument 3 has type ‘size_t’
>      {aka ‘unsigned int’} [-Wformat=]
>      75 | printf("UPL handoff written to %lx size %lx\n", addr, abuf_size(&buf));
>         |                                         ~~^           ~~~~~~~~~~~~~~~
>         |                                           |           |
>         |                                           |           size_t {aka unsigned int}
>         |                                           long unsigned int
>         |                                         %x
> 
> Fixes: 264f4b0b34c0 ("upl: Add a command")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>   cmd/upl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/cmd/upl.c b/cmd/upl.c
> index c9745886507..4996f36c787 100644
> --- a/cmd/upl.c
> +++ b/cmd/upl.c
> @@ -72,7 +72,7 @@ static int do_upl_write(struct cmd_tbl *cmdtp, int flag, int argc,
>   		return CMD_RET_FAILURE;
>   	}
>   	addr = map_to_sysmem(abuf_data(&buf));
> -	printf("UPL handoff written to %lx size %lx\n", addr, abuf_size(&buf));
> +	printf("UPL handoff written to %lx size %zx\n", addr, abuf_size(&buf));
>   	if (env_set_hex("upladdr", addr) ||
>   	    env_set_hex("uplsize", abuf_size(&buf))) {
>   		printf("Cannot set env var\n");

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis
