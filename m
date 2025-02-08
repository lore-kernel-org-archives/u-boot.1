Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D16C0219B
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 21:16:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE74F80805;
	Sat,  8 Feb 2025 22:16:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="ODpMdln/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B89DE80820; Sat,  8 Feb 2025 22:16:15 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADB34807FE
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 22:16:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1739049371; x=1739654171; i=xypron.glpk@gmx.de;
 bh=6xj0y6bKnJYszzkyyONHGb5tI0r7CAe6yyz6Pv9GtXw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=ODpMdln/In9B3Y1Lhf5NYg+FTb8gxdireSP+XrBs284guyon9xzKx0bsEr2kSD0s
 rpza7W3TW44KK02nEPHobuz0Szpa74w/ZSKmqjuX0+0NbVgmvCYvgnXFmqPg2z72+
 95JWgCgiJxLeiNao+DArSNfW8vVwvNnPUz71gfXUtEPCdEksPkvgGVcX6otUKuc0P
 6/eQdD/XT+MoIzxAcqbPlBgIXgT8J9oqMpk/FNc2Qdnjz3JMnUL3fee4+ArF9mtgU
 dCFNdSf47Tq7wgt5i5HCJ1fkB4Wpb1qBPGOH6naPwI/HPY0iH7lkCmumdx5pO6UXl
 CLdlkiRiNsvv8r9CwA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKKZ3-1tyfun3IXX-00Outv; Sat, 08
 Feb 2025 22:16:10 +0100
Message-ID: <81d8e212-3dd4-4fec-a465-05dc704e0d87@gmx.de>
Date: Sat, 8 Feb 2025 22:16:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] cmd: fat: Add fatrnfile command
To: Daniel Venzin <Daniel.Venzin@mt.com>
Cc: burak@gerz.io, gabriel.dalimonte@gmail.com, Manuel.Traut@mt.com,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Nam Cao
 <namcao@linutronix.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20250207124523.85026-1-Daniel.Venzin@mt.com>
 <20250207124523.85026-6-Daniel.Venzin@mt.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250207124523.85026-6-Daniel.Venzin@mt.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:acCZFgR6oaO5sHNrpUHsR4rrsu4IV6Fq1kL8m4QS2/gQUgTXAMx
 pA6i/UPqCtn8obEGYUesmYdBCfnG34MZSxwjxgqTATtPyLOc3IDzfyusd7sdj/e+Hub5Mo/
 GGxHomhKbgrCYkaLL04WE3IcuqEEVVV6+3Yi/TeWAVVCnap9w55wxTGahA8JDT5BmPfq1c8
 NbjYcf/4C91jODYcPel5Q==
UI-OutboundReport: notjunk:1;M01:P0:3GPlZtRM9Og=;mBZH1XU2LniSW4K5c3WkUJDKI+L
 TRS1Mv+CaCNLpxhp/JavHGTRGWIktZLC5AnpuJxJQKrF+qfY41ho19MZP97C2WZs5Dn+s4Z7R
 IyFxOXdjAcIAoc1ycHrCdzwdQDi89B4U6NTzvJc+JskEAkG3Jh2qLQPE1EYZz1TgZWCXSpbMV
 E0bZ3JATw1oPQWYQRI3BqVPLB/qjmwUAm6LI+erzd9Jr2ptZeU9JzkMiCsNM2T9pHTIyg0Z5G
 tj4vzacnJy8RK+TOxRYw2RFE6NesPLI3vzO35sOTDoplCjC3sGDKtijQYphaNPbObbue46HEP
 JxGaIijfRimRWQnWjQPRJUGNkaWpdxVxLVeOBrrbLSguOSZWShDvI15RnEbWec6EA78W2PG4o
 hO1AieUQfFwNgdscyMQJrESUDy0xUBZhVlH5d6dkbclUeLeTzpkUN2obvX0YdulXv2AzS14a5
 yCWumgwSJRTvWWj5HsXe3Tij1kNx+M0woxNHVaHxWSvTu4Hz9rCfMkps6iyUVOufFNK/09pOW
 hZFIKIXd/BsrB3LSReQjPUq3CJvW+jVfdkU8TBiw6eUeMUnI1DueRhAxAiSQ7zfpeGFp2oXxY
 oFHNojag/9wefCwQ3F7J34pbjSGNNkKAqardbjtS3UpifbSDLyTsnFuDFtVEiThdgqaAEyoLj
 lghsS+aU/3ecdpqT5M6GMIaK2b+J8E3+boGN4N0U6lpONSAz5peHaNbvL+9QrAtO7nltx2FaN
 7tyLzotyU3kQdKtRdrwNK3/N7AwVddgIgGQ/5fxihDAfBaUl71D/s0f1yGJFXK7cSNPSw0J4l
 9mPkWTZri+pKMl+NlvmS04K0YupQKUgEPIUb1DN9D57vTYt6lxONBtbNbaixggLH7xMNaw306
 eZaNBVQqTLmh5YN8Oo7l6zr/1/jLVzlkBEvBXh07aYHSHBbf5lx4bqS1Dl91GTWi/d9DPagPV
 2Zf9x++a5+dmfen9Za4GZEr38gO3efT6DQyPQr5D/+j6g694/mgdB7mM/iQ+gYYNGcYbnWuLd
 Kz2iRfCzXozJ79QvR72axt1Le4XjONOKLNIlO8ob8pfwWmCKipnXyf4TXCbURNHnsy+/IzZIP
 6OHY0dMKwZFuKuDlBlwwQ7As7BfiNtyKYnjLplvXen6PcitKQtXR3ctXjqsDcwk6wOJMpPFty
 F7oO5IbWnmOuVEd+E+oPU0QAcQvwAGAbEwG1n9VJPPdRfCh/TD4uuBGYcMP0Re1ZgUpwT7YR2
 hFnMw7tP1/JJM1SHo5ASwiLIX3taWGjeddsDBgw3U+bUOdDCIetj8VBt4+ED6pNHq4G/uGwef
 R4vFwIgh0M94/YEl74hQ3plKPz5vsRnIAVJwdYLDQIT9XFiMh7MSkBLm9gBPcINSMQ9N2XiqY
 enqI//YUZT8TIvdjyX8RIctJtXPyWR/FW2DJ2jDDZlvrqHi/XvRjzxhF03/yzvHZhI7q66ZeD
 K6B/m7Q==
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

On 2/7/25 13:45, Daniel Venzin wrote:
> The FAT rename file command supports renaming of a file,
> used by fs_test test suite.
>
> Signed-off-by: Daniel Venzin <Daniel.Venzin@mt.com>
>
> ---
>
> Changes in v3:
> - Add fatrnfile command for renaming files in a FAT file system
>
>   cmd/fat.c    | 13 +++++++++++++
>   fs/fs.c      | 20 ++++++++++++++++++++
>   include/fs.h |  2 ++
>   3 files changed, 35 insertions(+)
>
> diff --git a/cmd/fat.c b/cmd/fat.c
> index 5b7484dc1af..c66583cb427 100644
> --- a/cmd/fat.c
> +++ b/cmd/fat.c
> @@ -132,4 +132,17 @@ U_BOOT_CMD(
>   	"<interface> [<dev[:part]>] <directory>\n"
>   	"    - create a directory in 'dev' on 'interface'"
>   );
> +
> +static int do_fat_rnfile(struct cmd_tbl *cmdtp, int flag, int argc,
> +			char *const argv[])
> +{
> +	return do_rnfile(cmdtp, flag, argc, argv, FS_TYPE_FAT);
> +}
> +
> +U_BOOT_CMD(
> +	fatrnfile,	5,	1,	do_fat_rnfile,
> +	"rename a file",
> +	"<interface> [<dev[:part]>] <source> <destination>\n"
> +	"    - rename <source> to <destination> in 'dev' on 'interface'"
> +);
>   #endif
> diff --git a/fs/fs.c b/fs/fs.c
> index 3576d5c6644..fafe00cdb9c 100644
> --- a/fs/fs.c
> +++ b/fs/fs.c
> @@ -990,6 +990,26 @@ int do_mkdir(struct cmd_tbl *cmdtp, int flag, int a=
rgc, char *const argv[],
>   	return 0;
>   }
>
> +int do_rnfile(struct cmd_tbl *cmdtp, int flag, int argc, char *const ar=
gv[],
> +	     int fstype)
> +{
> +	int ret;
> +
> +	if (argc !=3D 5)
> +		return CMD_RET_USAGE;
> +
> +	if (fs_set_blk_dev(argv[1], argv[2], fstype))
> +		return 1;
> +
> +	ret =3D fs_rename(argv[3], argv[4]);
> +	if (ret) {
> +		log_err("** Unable to rename file from \"%s\" to \"%s\" **\n", argv[3=
], argv[4]);
> +		return 1;

The test should test not only test the positive case but also the cases
where we expect moving or renaming a file to fail.

Best regards

Heinrich

> +	}
> +
> +	return 0;
> +}
> +
>   int do_ln(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[=
],
>   	  int fstype)
>   {
> diff --git a/include/fs.h b/include/fs.h
> index 8c1aa9c1a7b..79dc442ea75 100644
> --- a/include/fs.h
> +++ b/include/fs.h
> @@ -297,6 +297,8 @@ int do_rm(struct cmd_tbl *cmdtp, int flag, int argc,=
 char *const argv[],
>   	  int fstype);
>   int do_mkdir(struct cmd_tbl *cmdtp, int flag, int argc, char *const ar=
gv[],
>   	     int fstype);
> +int do_rnfile(struct cmd_tbl *cmdtp, int flag, int argc, char *const ar=
gv[],
> +	     int fstype);
>   int do_ln(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[=
],
>   	  int fstype);
>

