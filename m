Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 910CAC25B75
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 01:53:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A323188176;
	Thu, 16 May 2024 03:53:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1715824390;
	bh=mEqD2WMQJ5xWNqD1vzLuGZsRV/QpTJCAD3HsP38kYV0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FYQBsi4X/jY1tWYGC0bw73GQQJsbydc+G+yHOkXlK+HO0eV1ob0KF5EKW/SHlh/OT
	 fErk0XhOOUtAx6edaAJWweTXMeltDRhg3CZaZEyreOd+BidkDAXtoFVsT08uQjxz3r
	 nweDZi+I5bT/IhMD5zx35NgIahbPqdFVz8DTORyV7V9thFgoNDpNLXTnsbJJuBdzeK
	 9jEdo4gqQV1L4UEBlVVvY1PQV/QiWNlnm5E4igXixKGoWR8/PheKXtBZG9VxSvjRQl
	 YEDqGg4q9dvOA9dU/H2yqlDNdq3K9H2ZpfZ4PXTBfWU+iMfDfkvIjVoAKrDpNJ+tQQ
	 88N5osxBHteTQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 3194A8800C;
 Thu, 16 May 2024 03:53:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1715824389;
 bh=mEqD2WMQJ5xWNqD1vzLuGZsRV/QpTJCAD3HsP38kYV0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=MlSm/5J3/+es4EwgVJyDk1GE/H9jyPGgY67tdajZ5ZEpipyj0xWKppQNG9ycx/hRh
 fDe+OEkBAQm/o/1k9qvGJCOUyV3xfM6YezRMMvQQMrS698115dBKbAeogN6J83rN/M
 OIpfj39/3Wi36edyAnzoVwYXZq5Y+BK+bE14ubYR6FFjB12ZPA+WFZbfdgw7u70urR
 AIpBo0dlXUwNCLLecQyoN//76kG880nDgHwi8YR4oD6nfHal5SDEaNptc0jlwP4dlF
 qt7EBs+kvCCsViFsokvxGZq9YpwquaUNv2ZM7A6dpH+JtYn77BUJ7INy/A9sH+fjVw
 D5iDuT2ctkWqA==
Message-ID: <272ca2c6-9a33-4252-8d8f-45d1cccf3f33@denx.de>
Date: Thu, 16 May 2024 03:53:07 +0200
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
 <1bb31e71-6fe3-44ce-90dc-6bc7a7fc4d94@denx.de>
 <CAJ+vNU0F1Xa4Tm5P=eC5DgidLSGD8sKfjZ=y9J7Fx4kW01qoFQ@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAJ+vNU0F1Xa4Tm5P=eC5DgidLSGD8sKfjZ=y9J7Fx4kW01qoFQ@mail.gmail.com>
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

On 5/16/24 12:31 AM, Tim Harvey wrote:

Hi,

> (this is a resend... apologies if its a duplicate. I got some strange
> bounce that mime types were included so I'm resending with the otuput
> of strace cliped out)
> 
> strace was a good idea and showed me what was going on.
> 
> The previous documentation stated to pass your keys via env vars that
> were full paths to key certificates. Using strace shows me that it
> will use the directory the KEY certificate is in and try to open up
> ../keys/*_usr_key.pem if the key path is specified. So apparently the
> 'File' in the CST config file is used indirectly. Pointing to the
> usr_key.pem isn't enough either by the way, it seems to need both of
> these:
> 
> so if I hack the path to my certs in like this it works:diff --git
> a/tools/binman/etype/nxp_imx8mcst.py
> b/tools/binman/etype/nxp_imx8mcst.py
> index 132127ad4827..b432200960df 100644
> --- a/tools/binman/etype/nxp_imx8mcst.py
> +++ b/tools/binman/etype/nxp_imx8mcst.py
> @@ -67,10 +67,11 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
> 
>       def ReadNode(self):
>           super().ReadNode()
> +        self.certpath =3D '/usr/src/nxp/cst-3.3.2/crts/';

=3D , seems like your email is acting funny today indeed.

>           self.loader_address =3D fdt_util.GetInt(self._node, 'nxp,loader-ad=
> dress')
>           self.srk_table =3D fdt_util.GetString(self._node,
> 'nxp,srk-table', 'SRK_1_2_3_4_table.bin')
> -        self.csf_crt =3D fdt_util.GetString(self._node, 'nxp,csf-crt',
> 'CSF1_1_sha256_4096_65537_v3_usr_crt.pem')
> -        self.img_crt =3D fdt_util.GetString(self._node, 'nxp,img-crt',
> 'IMG1_1_sha256_4096_65537_v3_usr_crt.pem')
> +        self.csf_crt =3D fdt_util.GetString(self._node, 'nxp,csf-crt',
> self.certpath + '/CSF1_1_sha256_4096_65537_v3_usr_crt.pem')
> +        self.img_crt =3D fdt_util.GetString(self._node, 'nxp,img-crt',
> self.certpath + '/IMG1_1_sha256_4096_65537_v3_usr_crt.pem')

What about this:

diff --git a/tools/binman/etype/nxp_imx8mcst.py 
b/tools/binman/etype/nxp_imx8mcst.py
index 132127ad482..9ead7488a2d 100644
--- a/tools/binman/etype/nxp_imx8mcst.py
+++ b/tools/binman/etype/nxp_imx8mcst.py
@@ -68,9 +68,9 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
      def ReadNode(self):
          super().ReadNode()
          self.loader_address = fdt_util.GetInt(self._node, 
'nxp,loader-address')
-        self.srk_table = fdt_util.GetString(self._node, 
'nxp,srk-table', 'SRK_1_2_3_4_table.bin')
-        self.csf_crt = fdt_util.GetString(self._node, 'nxp,csf-crt', 
'CSF1_1_sha256_4096_65537_v3_usr_crt.pem')
-        self.img_crt = fdt_util.GetString(self._node, 'nxp,img-crt', 
'IMG1_1_sha256_4096_65537_v3_usr_crt.pem')
+        self.srk_table = os.getenv('SRK_TABLE', 
fdt_util.GetString(self._node, 'nxp,srk-table', 'SRK_1_2_3_4_table.bin'))
+        self.csf_crt = os.getenv('CSF_KEY', 
fdt_util.GetString(self._node, 'nxp,csf-crt', 
'CSF1_1_sha256_4096_65537_v3_usr_crt.pem'))
+        self.img_crt = os.getenv('IMG_KEY', 
fdt_util.GetString(self._node, 'nxp,img-crt', 
'IMG1_1_sha256_4096_65537_v3_usr_crt.pem'))
          self.unlock = fdt_util.GetBool(self._node, 'nxp,unlock')
          self.ReadEntries()

Then you can also use the old behavior with keys supplied via env vars.

This might in fact be useful for build systems too.

>           self.unlock =3D fdt_util.GetBool(self._node, 'nxp,unlock')
>           self.ReadEntries()
> 
> $ make -j8
>    BINMAN  .binman_stamp
>    OFCHK   .config
> 
> Strace indicatest the following with the above patch:
> openat(AT_FDCWD,
> "/usr/src/nxp/cst-3.3.2/crts//IMG1_1_sha256_4096_65537_v3_usr_crt.pem",
> O_RDONLY)
> ...
> openat(AT_FDCWD,
> "/usr/src/nxp/cst-3.3.2/keys//IMG1_1_sha256_4096_65537_v3_usr_key.pem",
> O_RDONLY)
> ^^^ look how it sneakily changes the PATH!
> 
> And without the above patch using a key file without a path:
> openat(AT_FDCWD, "IMG1_1_sha256_4096_65537_v3_usr_crt.pem", O_RDONLY)
> ...
> openat(AT_FDCWD, "IMG1_1_sha256_4096_65537_v3_usr_key.pem", O_RDONLY)
> ENOENT (No such file or directory)
> ^^^ fails
> 
> Simply copying both usr_crt.pem and usr_key.pem to the build directory
> still fails:
> binman: Error 1 running 'cst -i
> ./nxp.csf-config-txt.section.nxp-imx8mcst@0 -o
> ./nxp.csf-output-blob.section.nxp-imx8mcst@0': Error:
> Cannot open key file IMG1_1_sha256_4096_65537_v3_usr_key.pem
> 0:error:06065064:digital envelope routines:EVP_DecryptFinal_ex:bad
> decrypt:crypto/evp/evp_enc.c:612:
> 0:error:23077074:PKCS12 routines:PKCS12_pbe_crypt:pkcs12 cipherfinal
> error:crypto/pkcs12/p12_decr.c:62:
> 0:error:2306A075:PKCS12 routines:PKCS12_item_decrypt_d2i:pkcs12 pbe
> crypt error:crypto/pkcs12/p12_decr.c:93:
> 0:error:0907B00D:PEM routines:PEM_read_bio_PrivateKey:ASN1
> lib:crypto/pem/pem_pkey.c:88:
> 
> Do you not run into this and if not is it because you have put full
> paths in the dtsi overriding the defaults I'm using?

I just do '$ cp -Lv /CST/{keys,crts}/* .' to copy the keys and certs 
into the build directory for testing.

> Maybe this has
> something to do with how my keys were generated or the version of cst
> I'm using or maybe we just need to also add a directory which can be
> symlinked to or something.

I use the imx-code-signing-tool 3.4.0+dfsg-2+b1 from debian .

> Another thing that I'm seeing is that this leaves a bunch of turd files around:
>          cfg-out.section.nxp-imx8mcst@0.nxp-imx8mimage
>          cfg-out.section.nxp-imx8mimage
>          input.section.nxp-imx8mcst@0
>          input.section.nxp-imx8mcst@0.nxp-imx8mimage
>          input.section.nxp-imx8mimage
>          nxp.csf-config-txt.section.nxp-imx8mcst@0
>          nxp.cst-input-data.section.nxp-imx8mcst@0
>          nxp.imx8mimage.cfg.section.nxp-imx8mcst@0.nxp-imx8mimage
>          nxp.imx8mimage.cfg.section.nxp-imx8mimage
> 
> These intermediate files should be cleaned up after signing is complete.

Those are intermediate build artifacts, sort of like .o files or such, 
so they should be OK to keep around, right ?
