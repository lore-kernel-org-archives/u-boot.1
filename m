Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE93AC04FFE
	for <u-boot@archiver.kernel.org>; Tue, 14 May 2024 20:58:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C14C288013;
	Tue, 14 May 2024 22:58:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1715720309;
	bh=3WYSPDlyBGj48k9GjqB3/Bv9DZD5qp795GteTdXWLEg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bInhssh7fPJgLBMzoRykgrVSvstV6TW4SQozZxJxtCqBmqBwzyMfgKsqben005h4v
	 AnjtlgdaGJW5t1BxWm0iNNlRuFhwjJXOK9NjKRJ1PsE4M4i2DcJJ9STGp2DyjU+fHF
	 Pdy7l5DvE8hdLht2OMu6VCH9nUqS9X9d4/sb86cAFcVp3j/kezYU5Zw3cvSziMz+Og
	 zf7Y0heFP9Xs2JKrnnBd9gE5N5ftRn3fZS2w6yCIaZc36hyt2CysBgiRoubgIyWm30
	 YC0a5EgQWRXSHKYY2MI8qaP2ZzTI5pDEQbTegXnTcqNLVhQVk/0qs7pede550L8akd
	 GkMjI2jS7Bbug==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id A32B5880B5;
 Tue, 14 May 2024 22:58:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1715720309;
 bh=3WYSPDlyBGj48k9GjqB3/Bv9DZD5qp795GteTdXWLEg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=A4gnQAmzGSAf+pVbLsEBkI+j+Uq/zN0/SIm+H1/ucv9E3xpu58Lx31K4kZzjj5luL
 pLU+99/WPPMDDBx1YjV/iv4JYPnNPer+od7C6ZVUj6C8DhjVnYtA+yOYE8439NonVX
 0+uquwq7x/oSVdzkGTeXAQ/0kUNA5q0fDS3VWCZKCheeVoa6t6QlNtgM5gNYy1T8v8
 eiGTuW8Xy/Qehqju2a83pdYqn+WT0kEI3ljUX9+ip3TZ7ORRLehbwduU6UOm8Mm4Gr
 h8WuglEQBlb+0SFDcJcdSx5ByyOtfK7E+lTsEPRQpGo2aZl1Ssp4Ba1f+i7Wm/VuLU
 pu70D2/s8lodw==
Message-ID: <1bb31e71-6fe3-44ce-90dc-6bc7a7fc4d94@denx.de>
Date: Tue, 14 May 2024 22:23:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] imx: hab: Use nxp_imx8mcst etype for i.MX8M
 flash.bin signing
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, anton.gres@ifm.com, ch@denx.de,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Adam Ford <aford173@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Angus Ainslie <angus@akkea.ca>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Simon Glass
 <sjg@chromium.org>, Stefan Eichenberger <stefan.eichenberger@toradex.com>,
 Stefano Babic <sbabic@denx.de>, Tom Rini <trini@konsulko.com>,
 kernel@puri.sm, u-boot@dh-electronics.com
References: <20240503010518.263458-1-marex@denx.de>
 <20240503010518.263458-4-marex@denx.de>
 <CAJ+vNU2=k911jK8rYuaCx7qUN9GyCF6GLjuhLi0y82+yq1hYng@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAJ+vNU2=k911jK8rYuaCx7qUN9GyCF6GLjuhLi0y82+yq1hYng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 5/14/24 8:34 PM, Tim Harvey wrote:

Hi,

>> diff --git a/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt b/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
>> index e16e5410bd9..ce1de659d8c 100644
>> --- a/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
>> +++ b/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
>> @@ -121,6 +121,9 @@ build configuration:
>>   - Defconfig:
>>
>>     CONFIG_IMX_HAB=y
>> +  CONFIG_FSL_CAAM=y
>> +  CONFIG_ARCH_MISC_INIT=y
>> +  CONFIG_SPL_CRYPTO=y
>>
> 
> Hi Marek,
> 
> Thanks for wrapping the dts bits with a config item.
> 
> Is there any other reason to build with CONFIG_IMX_HAB than to use a
> signed image? I see that there are several ARCH_MX6 and ARCH_MX7
> configs that have this enabled (not ARCH_IMX8M so this certainly
> doesn't break anything) and I'm not sure what the value of that is.

I think those few either enabled in preemptively in anticipation of 
possibly using HAB, or are wrong. I suspect it should be disabled for 
those, as it only adds to the board boot time and I am not even sure if 
those machines would boot correctly.

Francesco, maybe you do have MX7 Colibri ?

> I notice that FSL_CAAM is selected when you select IMX_HAB... is there
> any reason why ARCH_MISC_INIT and SPL_CRYPTO should not be selected by
> IMX_HAB as well (future patch perhaps)?

ARCH_MISC_INIT should be selected by SoC Kconfig on MX7 and maybe CAAM 
on MX8M I think . As for SPL_CRYPTO, that should be selected by 
SPL_FSL_CAAM I think.

>>   - Kconfig:
>>
> 
> We definitely need to describe the additional requirements here. Maybe
> something like:
> 
> - Tools:
> cst - NXP code-signing-tool (eg apt install imx-code-signing-tool)
> 
> - Files: (created with NXP IMX_CST_TOOL)
> SRK_1_2_3_4_table.bin (specified by nxp,srk-table node): fuse table
> CSF1_1_sha256_4096_65537_v3_usr_crt.pem (specified by nxp,csf-crt node): CSF_KEY
> IMG1_1_sha256_4096_65537_v3_usr_crt.pem (specified by nxp,img-crt node): IMG_KEY
> 
> The following works fine for me on v2024.01
> export CST_DIR=/usr/src/nxp/cst-3.3.2/
> export CSF_KEY=$CST_DIR/crts/CSF1_1_sha256_4096_65537_v3_usr_crt.pem
> export IMG_KEY=$CST_DIR/crts/IMG1_1_sha256_4096_65537_v3_usr_crt.pem
> export SRK_TABLE=$CST_DIR/crts/SRK_1_2_3_4_table.bin
> export PATH=$CST_DIR/linux64/bin:$PATH
> make && /bin/sh doc/imx/habv4/csf_examples/mx8m/csf.sh
> 
> But with the above defines and your series this fails:
> ln -sf $SRK_TABLE SRK_1_2_3_4_table.bin
> ln -sf $CSF_KEY CSF1_1_sha256_4096_65537_v3_usr_crt.pem
> ln -sf $IMG_KEY IMG1_1_sha256_4096_65537_v3_usr_crt.pem
> make
>    BINMAN  .binman_stamp
> Wrote map file './image.map' to show errors
> binman: Error 1 running 'cst -i
> ./nxp.csf-config-txt.section.nxp-imx8mcst@0 -o
> ./nxp.csf-output-blob.section.nxp-imx8mcst@0': Error:
> Cannot open key file IMG1_1_sha256_4096_65537_v3_usr_key.pem
> 0:error:02001002:system library:fopen:No such file or
> directory:crypto/bio/bss_file.c:288:fopen('IMG1_1_sha256_4096_65537_v3_usr_key.
> pem','r')
> 0:error:20074002:BIO routines:file_ctrl:system lib:crypto/bio/bss_file.c:290:
> 
> make: *** [Makefile:1126: .binman_stamp] Error 1
> 
> So how is it that the default for nxp,img-crt
> IMG1_1_sha256_4096_65537_v3_usr_crt.pem is now looking for
> IMG1_1_sha256_4096_65537_v3_usr_key? It fails also if I cp the files
> vs ln them.
> 
> So what am I missing here?

I think CST is using both the certificate and the key files. Try and run 
strace on the CST to test that:

$ strace cst -i ./nxp.csf-config-txt.section.nxp-imx8mcst@0 -o 
./nxp.csf-output-blob.section.nxp-imx8mcst@0
