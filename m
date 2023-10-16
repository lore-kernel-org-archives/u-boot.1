Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD961CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 11:45:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7C5E8667B;
	Mon, 16 Oct 2023 13:45:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="cQoA0hTh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0191A867D6; Mon, 16 Oct 2023 13:45:44 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3270286335
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 13:45:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39GBjZZR084882;
 Mon, 16 Oct 2023 06:45:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1697456735;
 bh=DAPoemc9HhEb1IIETRLi8ZM09YnM2uYnPhP0zCnrOuM=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=cQoA0hThI6GvexdExwqd2amiPl6pHQEnBjsjBrX+lFk1ui1zpLxkEvrFPTXJw6eIL
 q+eEK8X/GLOWTWvegOt+6HxX51IDhQtlNTXqIt26G6GJy75t41yqj+k4J0tAB1nPPz
 O2ZMdxl09QI8sUMVnSCuIpPSjBx3keBr7JKt7Ucw=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39GBjZjX093470
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 16 Oct 2023 06:45:35 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 16
 Oct 2023 06:45:34 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 16 Oct 2023 06:45:35 -0500
Received: from [10.24.68.114] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39GBjWgJ105799;
 Mon, 16 Oct 2023 06:45:33 -0500
Message-ID: <ee189e3a-7ba2-4367-9ba4-4a959bf8bdf9@ti.com>
Date: Mon, 16 Oct 2023 17:15:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] binman: Don't add compression attribute for
 uncompressed files
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Bin Meng <bmeng.cn@gmail.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Philippe Reynes
 <philippe.reynes@softathome.com>, Stefan Herbrechtsmeier
 <stefan.herbrechtsmeier@weidmueller.com>
References: <20231014204033.3077052-1-sjg@chromium.org>
 <20231014204033.3077052-3-sjg@chromium.org>
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20231014204033.3077052-3-sjg@chromium.org>
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

Hi Simon

On 15/10/23 02:10, Simon Glass wrote:
> cbfsutil changed to skip adding a compression attribute if there is no
> compression. Adjust the binman implementation to do the same.
> 
> This mirrors commit 105cdf5625 in coreboot.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>   tools/binman/cbfs_util.py      | 13 ++++++++-----
>   tools/binman/cbfs_util_test.py |  8 ++++----
>   tools/binman/ftest.py          |  6 +++---
>   3 files changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/binman/cbfs_util.py b/tools/binman/cbfs_util.py
> index fc56b40b7531..92d2add25146 100644
> --- a/tools/binman/cbfs_util.py
> +++ b/tools/binman/cbfs_util.py
> @@ -333,7 +333,8 @@ class CbfsFile(object):
>           if self.ftype == TYPE_STAGE:
>               pass
>           elif self.ftype == TYPE_RAW:
> -            hdr_len += ATTR_COMPRESSION_LEN
> +            if self.compress:
> +                hdr_len += ATTR_COMPRESSION_LEN
>           elif self.ftype == TYPE_EMPTY:
>               pass
>           else:
> @@ -369,9 +370,11 @@ class CbfsFile(object):
>                   data = self.comp_bintool.compress(orig_data)
>               self.memlen = len(orig_data)
>               self.data_len = len(data)
> -            attr = struct.pack(ATTR_COMPRESSION_FORMAT,
> -                               FILE_ATTR_TAG_COMPRESSION, ATTR_COMPRESSION_LEN,
> -                               self.compress, self.memlen)
> +            if self.compress:
> +                attr = struct.pack(ATTR_COMPRESSION_FORMAT,
> +                                   FILE_ATTR_TAG_COMPRESSION,
> +                                   ATTR_COMPRESSION_LEN, self.compress,
> +                                   self.memlen)
>           elif self.ftype == TYPE_EMPTY:
>               data = tools.get_bytes(self.erase_byte, self.size)
>           else:
> @@ -405,7 +408,7 @@ class CbfsFile(object):
>           if expected_len != actual_len:  # pragma: no cover
>               # Test coverage of this is not available since this should never
>               # happen. It probably indicates that get_header_len() is broken.
> -            raise ValueError("Internal error: CBFS file '%s': Expected headers of %#x bytes, got %#d" %
> +            raise ValueError("Internal error: CBFS file '%s': Expected headers of %#x bytes, got %#x" %
>                                (self.name, expected_len, actual_len))
>           return hdr + name + attr + pad + content + data, hdr_len
>   
> diff --git a/tools/binman/cbfs_util_test.py b/tools/binman/cbfs_util_test.py
> index ee951d10cf3b..c3babbc64e78 100755
> --- a/tools/binman/cbfs_util_test.py
> +++ b/tools/binman/cbfs_util_test.py
> @@ -96,7 +96,7 @@ class TestCbfs(unittest.TestCase):
>           self.assertEqual(arch, cbfs.arch)
>           return cbfs
>   
> -    def _check_uboot(self, cbfs, ftype=cbfs_util.TYPE_RAW, offset=0x38,
> +    def _check_uboot(self, cbfs, ftype=cbfs_util.TYPE_RAW, offset=0x28,
>                        data=U_BOOT_DATA, cbfs_offset=None):
>           """Check that the U-Boot file is as expected
>   
> @@ -122,7 +122,7 @@ class TestCbfs(unittest.TestCase):
>           self.assertEqual(len(data), cfile.memlen)
>           return cfile
>   
> -    def _check_dtb(self, cbfs, offset=0x38, data=U_BOOT_DTB_DATA,
> +    def _check_dtb(self, cbfs, offset=0x28, data=U_BOOT_DTB_DATA,
>                      cbfs_offset=None):
>           """Check that the U-Boot dtb file is as expected
>   
> @@ -598,8 +598,8 @@ class TestCbfs(unittest.TestCase):
>           data = cbw.get_data()
>   
>           cbfs = cbfs_util.CbfsReader(data)
> -        self.assertEqual(0x38, cbfs.files['u-boot'].cbfs_offset)
> -        self.assertEqual(0x78, cbfs.files['u-boot-dtb'].cbfs_offset)
> +        self.assertEqual(0x28, cbfs.files['u-boot'].cbfs_offset)
> +        self.assertEqual(0x68, cbfs.files['u-boot-dtb'].cbfs_offset)
>   
>   
>   if __name__ == '__main__':
> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> index 16156b741052..2875194d750e 100644
> --- a/tools/binman/ftest.py
> +++ b/tools/binman/ftest.py
> @@ -2670,9 +2670,9 @@ class TestFunctional(unittest.TestCase):
>               'cbfs/u-boot:offset': 0x38,
>               'cbfs/u-boot:uncomp-size': len(U_BOOT_DATA),
>               'cbfs/u-boot:image-pos': 0x38,
> -            'cbfs/u-boot-dtb:offset': 0xb8,
> +            'cbfs/u-boot-dtb:offset': 0xa8,
>               'cbfs/u-boot-dtb:size': len(U_BOOT_DATA),
> -            'cbfs/u-boot-dtb:image-pos': 0xb8,
> +            'cbfs/u-boot-dtb:image-pos': 0xa8,
>               }, props)
>   
>       def testCbfsBadType(self):
> @@ -2854,7 +2854,7 @@ class TestFunctional(unittest.TestCase):
>   '  u-boot                  0     4  u-boot             0',
>   '  section               100   %x  section          100' % section_size,
>   '    cbfs                100   400  cbfs               0',
> -'      u-boot            138     4  u-boot            38',
> +'      u-boot            128     4  u-boot            28',
>   '      u-boot-dtb        180   105  u-boot-dtb        80          3c9',
>   '    u-boot-dtb          500   %x  u-boot-dtb       400          3c9' % fdt_size,
>   '  fdtmap                %x   3bd  fdtmap           %x' %

Reviewed-by: Neha Malcom Francis

-- 
Thanking You
Neha Malcom Francis
