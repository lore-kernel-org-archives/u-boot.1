Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1FB8C6FD1F
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 09:56:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CE0088013;
	Tue, 26 Mar 2024 10:56:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="UwUP89aY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7B9687DF8; Tue, 26 Mar 2024 10:56:15 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE82588038
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 10:56:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42Q9u0Om054120;
 Tue, 26 Mar 2024 04:56:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1711446960;
 bh=Kg+7lcItu2qG1CyX6pFIqS7WeaZplZyEgiasT9kvFL4=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=UwUP89aY+Scvd3C5LZ4TCcL6ENDrUCLheSMUnxqv/E/YZFYgwfyserc1WRSdRaOmo
 mFRkLheZaODzL7Q5Ek6pnZ6JLv6rDvS2IHrt2XLA1WMazHMewC3dMJ8V6RG3352VE8
 WjewU6G1FhimXyRboxux5j/FOghylUhNw0Hjz4W0=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42Q9u0uC014593
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 26 Mar 2024 04:56:00 -0500
Received: from lewvowa02.ent.ti.com (10.180.75.80) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Mar 2024 04:56:00 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by lewvowa02.ent.ti.com
 (10.180.75.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2507.34; Tue, 26 Mar
 2024 04:55:59 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Mar 2024 04:55:59 -0500
Received: from [172.24.227.36]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42Q9tvAq115869;
 Tue, 26 Mar 2024 04:55:58 -0500
Message-ID: <4aeb56bf-ec3f-4003-9771-6d405e419d9e@ti.com>
Date: Tue, 26 Mar 2024 15:25:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools: binman: ti_board_cfg: improve error message
Content-Language: en-US
To: Michael Walle <mwalle@kernel.org>, Simon Glass <sjg@chromium.org>, "Alper
 Nebi Yasak" <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
References: <20240326093934.2167180-1-mwalle@kernel.org>
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20240326093934.2167180-1-mwalle@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Hi Michael,

On 26/03/24 15:09, Michael Walle wrote:
> When there is a lint error the user gets the following cryptic message:
> 
>    binman: Node '/path/to/some/node': Yamllint error: 18: comments
> 
> This isn't very helpful. Improve the message to tell the user that the
> number is actually a line number and also tell the user in which file
> they have to look.
> 
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
>   tools/binman/etype/ti_board_config.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/binman/etype/ti_board_config.py b/tools/binman/etype/ti_board_config.py
> index 2c3bb8f7b56..c10d66edcb1 100644
> --- a/tools/binman/etype/ti_board_config.py
> +++ b/tools/binman/etype/ti_board_config.py
> @@ -248,7 +248,7 @@ class Entry_ti_board_config(Entry_section):
>   
>               yaml_config = config.YamlLintConfig("extends: default")
>               for p in yamllint.linter.run(open(self._config_file, "r"), yaml_config):
> -                self.Raise(f"Yamllint error: {p.line}: {p.rule}")
> +                self.Raise(f"Yamllint error: Line {p.line} in {self._config_file}: {p.rule}")
>               try:
>                   validate(self.file_yaml, self.schema_yaml)
>               except Exception as e:

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis
