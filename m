Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B560EA3F00
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 05:26:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0484D8341A;
	Tue, 10 Feb 2026 06:26:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="dEmbmKxI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E8CC83C67; Tue, 10 Feb 2026 06:26:19 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29E9A8309A
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 06:26:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 31A5510FA96; Tue, 10 Feb 2026 06:26:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1770701175;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=LfE/ncrIF5cTN7WaeYLnlUe7IEJ9+QBvmcMJTq1EJUU=;
 b=dEmbmKxIzjp751qjk+YFj28n+TZYGW0/2JjQ+/5axbAv5iJTZ1Ye+6q5TOUZ3CmKdlFA1q
 HSKF3p8Glngf9GfWGPJpLFiVeLeooAGzd4YSnITcJLGB1lyhUnVSUiW2DpHcR0r060xjBA
 6gceCwjq2FTk71ewUzZ9mAciLxn8VpRPaxvpAAtNmMO3T6JcMqF0r8GDMm0HaXx3R57EtB
 RnhZpZEH1umy8EtBn5TRftryPiCOleXWKOK2SPE9b4iI3iqd7kgcMsQmoBJd4n2b3umu+2
 Q/aKfa0iuV8u5NY5AD+9O4P4QhUwGPCxoZrI872nxF0q3OnWwDdD47F/7jz5UA==
Message-ID: <23a76123-9fe9-16f3-7464-2d0b6fe4147a@nabladev.com>
Date: Tue, 10 Feb 2026 06:26:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 0/2] lib: sm3: coverity fix and add documentation
Content-Language: en-US
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>
References: <20260123022552.100884-1-hs@nabladev.com>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20260123022552.100884-1-hs@nabladev.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hello Tom,

this series fixes a coverity issue and adds the missing doc for the
new sm3sum command... I got no further comments... may I ask, if it
could be applied?

Thanks!

bye,
Heiko

On 23.01.26 03:25, Heiko Schocher wrote:
> 
> patch "lib: sm3: fix coverity error" fixes a Coerity scan error,
> which is a good catch, as this part is from linux [1].
> 
> Running some hashes with this change and I see no problems,
> or wrong hashes [2] (Hashes calculated with the help of the
> webpage [3].
> 
> Patch 2 adds the missing documentation for the new sm3sum command
> which missed his way into mainline.
> 
> rebased series to
> commit 6b2d05748cf ("Merge tag 'u-boot-imx-master-20260117' of https://gitlab.denx.de/u-boot/custodians/u-boot-imx")
> 
> Azure build:
> https://dev.azure.com/hs0298/hs/_build/results?buildId=205&view=results
> 
> [1]
> https://elixir.bootlin.com/linux/v6.14/source/include/crypto/sm3_base.h#L86
> 
> [2]
> │   ├─[helios-uboot] tftpb ${tftpp}/abb1.txt
> │   │    ## ethernet@30bf0000 Waiting for PHY auto negotiation to complete....... done
> │   │    ## Using ethernet@30bf0000 device
> │   │    ## TFTP from server 192.168.3.1; our IP address is 192.168.3.41
> │   │    ## Filename '20260106/abb1.txt'.
> │   │    ## Load address: 0x50000000
> │   │    ## Loading: ##################################################  3 Bytes
> │   │    ##      0 Bytes/s
> │   │    ## done
> │   │    ## Bytes transferred = 3 (3 hex)
> │   ├─[helios-uboot] md.b ${loadaddr} ${filesize}
> │   │    ## 50000000: 41 42 42                                         ABB
> │   ├─[helios-uboot] sm3sum ${loadaddr} ${filesize}
> │   │    ## sm3_256 for 50000000 ... 50000002 ==> 2f2e2c6e076ebff98112d96081a9714d783eb6d8ea46a16fbfdc3b589f1c374b
> │   ├─[helios-uboot] tftpb ${tftpp}/abb2.txt
> │   │    ## Using ethernet@30bf0000 device
> │   │    ## TFTP from server 192.168.3.1; our IP address is 192.168.3.41
> │   │    ## Filename '20260106/abb2.txt'.
> │   │    ## Load address: 0x50000000
> │   │    ## Loading: ##################################################  52 Bytes
> │   │    ##      4.9 KiB/s
> │   │    ## done
> │   │    ## Bytes transferred = 52 (34 hex)
> │   ├─[helios-uboot] md.b ${loadaddr} ${filesize}
> │   │    ## 50000000: 41 42 43 44 45 46 47 48 49 4a 4b 4c 4d 4e 4f 50  ABCDEFGHIJKLMNOP
> │   │    ## 50000010: 51 52 53 54 55 56 57 58 59 5a 61 62 63 64 65 66  QRSTUVWXYZabcdef
> │   │    ## 50000020: 67 68 69 6a 6b 6c 6d 6e 6f 70 71 72 73 74 75 76  ghijklmnopqrstuv
> │   │    ## 50000030: 77 78 79 7a                                      wxyz
> │   ├─[helios-uboot] sm3sum ${loadaddr} ${filesize}
> │   │    ## sm3_256 for 50000000 ... 50000033 ==> e5e13e8215fe8eff7dcfd9375f3c3ff0674bd979dcd192539afc3562d45f1a5e
> │   ├─[helios-uboot] tftpb ${tftpp}/abb3.txt
> │   │    ## Using ethernet@30bf0000 device
> │   │    ## TFTP from server 192.168.3.1; our IP address is 192.168.3.41
> │   │    ## Filename '20260106/abb3.txt'.
> │   │    ## Load address: 0x50000000
> │   │    ## Loading: ##################################################  510 Bytes
> │   │    ##      49.8 KiB/s
> │   │    ## done
> │   │    ## Bytes transferred = 510 (1fe hex)
> │   ├─[helios-uboot] md.b ${loadaddr} ${filesize}
> │   │    ## 50000000: 53 4d 33 20 69 73 20 61 20 63 72 79 70 74 6f 67  SM3 is a cryptog
> │   │    ## 50000010: 72 61 70 68 69 63 20 68 61 73 68 20 66 75 6e 63  raphic hash func
> │   │    ## 50000020: 74 69 6f 6e 20 70 75 62 6c 69 73 68 65 64 20 62  tion published b
> │   │    ## 50000030: 79 20 74 68 65 20 53 74 61 74 65 20 43 72 79 70  y the State Cryp
> │   │    ## 50000040: 74 6f 67 72 61 70 68 79 20 41 64 6d 69 6e 69 73  tography Adminis
> │   │    ## 50000050: 74 72 61 74 69 6f 6e 20 6f 66 20 43 68 69 6e 61  tration of China
> │   │    ## 50000060: 20 61 6e 64 20 69 73 20 61 6c 73 6f 20 6b 6e 6f   and is also kno
> │   │    ## 50000070: 77 6e 20 61 73 20 74 68 65 20 63 6f 6d 6d 65 72  wn as the commer
> │   │    ## 50000080: 63 69 61 6c 20 63 72 79 70 74 6f 67 72 61 70 68  cial cryptograph
> │   │    ## 50000090: 69 63 20 53 4d 33 20 61 6c 67 6f 72 69 74 68 6d  ic SM3 algorithm
> │   │    ## 500000a0: 2e 20 54 68 65 20 22 53 4d 22 20 72 65 70 72 65  . The "SM" repre
> │   │    ## 500000b0: 73 65 6e 74 73 20 22 63 6f 6d 6d 65 72 63 69 61  sents "commercia
> │   │    ## 500000c0: 6c 20 63 72 79 70 74 6f 67 72 61 70 68 79 2c 22  l cryptography,"
> │   │    ## 500000d0: 20 77 68 69 63 68 20 72 65 66 65 72 73 20 74 6f   which refers to
> │   │    ## 500000e0: 20 63 72 79 70 74 6f 67 72 61 70 68 69 63 20 74   cryptographic t
> │   │    ## 500000f0: 65 63 68 6e 6f 6c 6f 67 79 20 66 6f 72 20 63 6f  echnology for co
> │   │    ## 50000100: 6d 6d 65 72 63 69 61 6c 20 75 73 65 20 74 68 61  mmercial use tha
> │   │    ## 50000110: 74 20 64 6f 65 73 20 6e 6f 74 20 69 6e 76 6f 6c  t does not invol
> │   │    ## 50000120: 76 65 20 73 74 61 74 65 20 73 65 63 72 65 74 73  ve state secrets
> │   │    ## 50000130: 2e 20 49 74 20 69 73 20 62 61 73 65 64 20 6f 6e  . It is based on
> │   │    ## 50000140: 20 74 68 65 20 65 6c 6c 69 70 74 69 63 20 63 75   the elliptic cu
> │   │    ## 50000150: 72 76 65 20 64 69 73 63 72 65 74 65 20 6c 6f 67  rve discrete log
> │   │    ## 50000160: 61 72 69 74 68 6d 20 70 72 6f 62 6c 65 6d 20 61  arithm problem a
> │   │    ## 50000170: 6e 64 20 69 73 20 75 73 65 64 20 74 6f 20 72 65  nd is used to re
> │   │    ## 50000180: 70 6c 61 63 65 20 69 6e 73 65 63 75 72 65 20 68  place insecure h
> │   │    ## 50000190: 61 73 68 20 61 6c 67 6f 72 69 74 68 6d 73 20 73  ash algorithms s
> │   │    ## 500001a0: 75 63 68 20 61 73 20 4d 44 35 20 61 6e 64 20 53  uch as MD5 and S
> │   │    ## 500001b0: 48 41 2d 31 2e 20 54 68 65 20 6f 75 74 70 75 74  HA-1. The output
> │   │    ## 500001c0: 20 6c 65 6e 67 74 68 20 6f 66 20 74 68 65 20 53   length of the S
> │   │    ## 500001d0: 4d 33 20 61 6c 67 6f 72 69 74 68 6d 20 69 73 20  M3 algorithm is
> │   │    ## 500001e0: 32 35 36 20 62 69 74 73 2c 20 74 68 65 20 73 61  256 bits, the sa
> │   │    ## 500001f0: 6d 65 20 61 73 20 53 48 41 2d 32 35 36 2e        me as SHA-256.
> │   ├─[helios-uboot] sm3sum ${loadaddr} ${filesize}
> │   │    ## sm3_256 for 50000000 ... 500001fd ==> 53ce46ca129071694bac8007680573d83b941ea156ce46d9cc45a648c1b7e291
> │   ├─Entering interactive shell...
> │   ├─Press CTRL+] three times within 1 second to exit.
> 
> u-boot=>
> 
> [3] https://www.toolhelper.cn/en/DigestAlgorithm/SM3
> 
> Changes in v2:
> rebased series to
> commit 6b2d05748cf ("Merge tag 'u-boot-imx-master-20260117' of https://gitlab.denx.de/u-boot/custodians/u-boot-imx")
> added Acked-by from Ilias
> Added comments from Quentin
> - fixed typo in commit subject
> - fixed a lot of style and spelling issues
> - added in parameters section the format of the input values
> - removed section "Return value"
> 
> Heiko Schocher (2):
>    lib: sm3: fix coverity error
>    doc: cmd: add documentation for sm3sum
> 
>   doc/usage/cmd/sm3sum.rst | 112 +++++++++++++++++++++++++++++++++++++++
>   lib/sm3.c                |   2 +-
>   2 files changed, 113 insertions(+), 1 deletion(-)
>   create mode 100644 doc/usage/cmd/sm3sum.rst
> 

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
