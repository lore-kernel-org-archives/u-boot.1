Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDAB606A32F
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 19:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wyfOi+ig;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=mjEfNAJV
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0ADBC6085B;
	Fri,  6 Nov 2026 19:18:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LbR5fwgbNcxa; Fri,  6 Nov 2026 19:18:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 93B2D608B0
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793992689;
	b=jlLiAdiQgS3g2P/RjisKvTkPHzyYlbyW+1lP8WY2yvOuOBfReqMgsixaucoVsktcZDpS
	 nMFvOJr1HwLqrqjMGsXEEow0vN9c+0ojRYAI9ch6hM05B6PAR3AZYG9wEQQKnFr7aes52
	 1bFNwhHJShrQ53/XNGHh4sKT+k5DgCHh2IlP3fSbMlrv8uM9r/HRLI2fkZtSLmQ/FAik9
	 WQZtl4edJJA+FJoTAi8GScx2jBqdP8ae2+aMxsBU+J69yUxwmeZmcvTXa2qQ0Zlyq6IRQ
	 buT/06QIIX0k8qQgfUx7fl81twECYwKFiUpeCtnfhL8zyBuVMzN6lKblhWaSwO6oiVg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793992689;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Provags-ID:
	 UI-OutboundReport:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=CwwELubiz82GrFtYumSX1mHk7NBa0hNeMK0nsfh1cI0=;
	b=fgyMhIMC+zIdrsbicd/25JSeshGx2+0CiHo84S/x2DpcX2IpirCrrOCxlAI5sPPIn0gj
	 oRuAxZo2aqkc0GKL6/JTq3iCIguGvSthzOCrOXWvO6fB+bJiBFcEH2zPNW/jWtNEasO3S
	 c5Q95A/h5jOrbI/8RzIZCJwbleeMha8CumVr+uRLKrmxb/ixPOlDsAk0DZp8X1rK/KFkA
	 DoMRjOztCRULVxbEQ8dKKrzUOeVw4OzfHxXHsRtbnMJVXF6n8R37stGL0VljeVKV/3P5n
	 94wpK6RFsXaheLiUvM1oqs8BMNotGbMUdBKQfebtjgFwDiBy7Gti2za1W1BYDk6677w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793992689;
	bh=CwwELubiz82GrFtYumSX1mHk7NBa0hNeMK0nsfh1cI0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wyfOi+ig5k1BmBjOE7YwyTzLCNwJRrmBU1wslGuClz3UMteHv2DZ319YcdrI2kq+5
	 KZkkeroWrbWTNQw2AxQWURMm6foGrG88riH2crrx97BiyT+k66vAWM0tWhUJ47I6dm
	 OsCPy3ynwEYf5TxEz+6V8zXfh4SYujPKqjGtVfA0Bp/ePC87j9lmiLOwYx2u0d8oug
	 FxS/HARgzd6KEHly6gkC6IaaQ7YQB5hzB0aTwxhEsb6YdEY2pW4LtikZPaA1oCP84C
	 o3prjqBmnPzOogprIznoCMT4VRHXwA3Sjn+Cm7jQYQfBPZNN3mpXOzBQuTD/dpluS6
	 YABMLqn9u1+Lg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 93B2D608B0;
	Fri,  6 Nov 2026 19:18:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 80D0432A
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 19:18:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 723B181113
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 19:18:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zaJJPsxXYSvc for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 19:18:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7D46D81108
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=212.227.15.18
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.15.18;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=mjEfNAJV
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7D46D81108
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 19:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1793992683; x=1794597483; i=xypron.glpk@gmx.de;
 bh=CwwELubiz82GrFtYumSX1mHk7NBa0hNeMK0nsfh1cI0=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=mjEfNAJV3JgJNq2zppPAuscuZ+HdOawQWet8KlkidziFwszHV15honzzzXxSDqRO
 2MLdTHQp8SVCaaTYQGXKPZ5W8QH0DMF8CdlKbVFXodfBppF3JRY2EQPKnREZz/pfv
 OY1fC94XqhSpIldXCeT+lmMQH6l2aJrIglhJRXA2FVkvyCZ9Tv65UyddSvh4TFued
 RckTQmbcgSW3dl0Kr4tTs6IPGgPynuZU8gBal6gzc0zYCnqO46zt/rcofOqdAXAGj
 tdOUmsgXS/zot3OQ77KjzKZQfhZwoykHsCJIyQVMfeAv4SLmD7Kn/CpU5owoRtkuG
 mEcmsCLjvr8EQxbeNw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N2mFi-1wMglj2n52-0138zr; Fri, 06
 Nov 2026 20:18:03 +0100
Message-ID: <8dbe616a-cc57-4697-af04-c36ddc26c79b@gmx.de>
Date: Fri, 6 Nov 2026 20:18:02 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] lib: add a stream sink for block devices
To: iav@iav.lv
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, u-boot@lists.u-boot-project.org,
 Tom Rini <trini@konsulko.com>, Jerome Forissier <jerome.forissier@arm.com>
References: <20261101-b4-wget-blk-r4-v1-0-e27a009e4043@iav.lv>
 <20261101-b4-wget-blk-r4-v1-3-e27a009e4043@iav.lv>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20261101-b4-wget-blk-r4-v1-3-e27a009e4043@iav.lv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JrB7qsZ4G/tXbDalETyPRukJ0ChNQ2sUvMPKjnvgKXJ8buNeV2k
 GOsNK3tO911lyrLsEHng6ds4GI+S6WRdsVazgfwotXPuXrfmpoN1erdUwsZz3X3TifpTaz3
 oaL7RTF0u/MObgYxBGu87FjD4Hg1pPDAUKk8cO17F4I+vC/mWs8gb7aG2/8IGB8o998bqbK
 lmibTg5CAlVaH8I9pyjFw==
UI-OutboundReport: notjunk:1;M01:P0:SO8TM+9FQg4=;OS3CvPvnRGiMGzVHGlZcQVKP0dz
 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
 s5LRR
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/1/26 06:53, Igor Velkov via B4 Relay wrote:
> From: Igor Velkov <iav@iav.lv>
>=20
> Writing a disk image while it downloads needs a writer that takes the
> data piece by piece and puts it on a block device, without the whole
> image in memory.
>=20
> Add sink_to_blk(). It takes the input through sink_write() in pieces of
> any size and writes it through a write buffer of a size the caller
> picks. sink_finish() pads the last block with zeroes, and sink_abort()
> drops the buffered tail of a stream that did not complete. Data that
> does not fit in the target area fails the stream.

U-Boot runs single threaded without interrupts.

Don't the TCP timeouts caused by writing to a block device make this=20
streaming highly inefficient?

What throuput do you reach on an embedded device. Not the sandbox.

Best regards

Heinrich

>=20
> sink_blk_area() turns "<dev>[.<hwpart>][:<part>|#<name>]" and a byte
> offset into a block range. Without a partition the range is the whole
> device, also on a partitioned one. A partition that lies outside the
> device is refused.
>=20
> Signed-off-by: Igor Velkov <iav@iav.lv>
> ---
>   configs/sandbox_defconfig |   1 +
>   include/stream_sink.h     |  75 ++++++++++++++++++
>   lib/Kconfig               |   8 ++
>   lib/Makefile              |   1 +
>   lib/stream_sink.c         | 189 ++++++++++++++++++++++++++++++++++++++=
++++++++
>   test/lib/Makefile         |   3 +
>   test/lib/stream_sink.c    | 137 +++++++++++++++++++++++++++++++++
>   7 files changed, 414 insertions(+)
>=20
> diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
> index a3fa5246082..94ec4a34c62 100644
> --- a/configs/sandbox_defconfig
> +++ b/configs/sandbox_defconfig
> @@ -404,6 +404,7 @@ CONFIG_ECDSA_VERIFY=3Dy
>   CONFIG_RSASSA_PSS=3Dy
>   CONFIG_TPM=3Dy
>   CONFIG_TPM_AUTOSTART=3Dy
> +CONFIG_STREAM_SINK=3Dy
>   CONFIG_ERRNO_STR=3Dy
>   CONFIG_GETOPT=3Dy
>   CONFIG_TEST_FDTDEC=3Dy
> diff --git a/include/stream_sink.h b/include/stream_sink.h
> new file mode 100644
> index 00000000000..f470b86bb02
> --- /dev/null
> +++ b/include/stream_sink.h
> @@ -0,0 +1,75 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Write a stream to a block device
> + */
> +
> +#ifndef __STREAM_SINK_H
> +#define __STREAM_SINK_H
> +
> +#include <blk.h>
> +#include <linux/types.h>
> +
> +struct stream_sink;
> +
> +/**
> + * sink_to_blk() - start writing a stream to a block device
> + *
> + * @dev:	the device
> + * @start:	first block to write
> + * @count:	blocks available from @start; more output fails the stream
> + * @wbuf:	size of the write buffer, a multiple of the block size
> + * Return:	the sink, or NULL with the reason printed
> + */
> +struct stream_sink *sink_to_blk(struct blk_desc *dev, lbaint_t start,
> +				lbaint_t count, size_t wbuf);
> +
> +/**
> + * sink_blk_area() - find the blocks that a command line names
> + *
> + * Without ":<part>" or "#<name>" the area is the whole device (or hard=
ware
> + * partition), which a raw write wants even where the device has a part=
ition
> + * table.
> + *
> + * @ifname:	interface, e.g. "mmc"
> + * @dev_part:	"<dev>[.<hwpart>][:<part>|#<name>]"
> + * @offs:	byte offset into the area, a multiple of the block size
> + * @dev:	returns the device
> + * @start:	returns the first block to write
> + * @count:	returns the blocks from @start to the end of the area
> + * Return:	0, or a negative error with the reason printed
> + */
> +int sink_blk_area(const char *ifname, const char *dev_part, u64 offs,
> +		  struct blk_desc **dev, lbaint_t *start, lbaint_t *count);
> +
> +/**
> + * sink_write() - feed the next piece of the stream
> + *
> + * @s:		the sink
> + * @buf:	input data
> + * @len:	length of @buf
> + * Return:	0, or a negative error with the reason printed
> + */
> +int sink_write(struct stream_sink *s, const void *buf, size_t len);
> +
> +/**
> + * sink_finish() - complete the stream and release the sink
> + *
> + * This writes out the last partial block padded with zeroes and frees =
@s.
> + * After a failed sink_write() it only frees @s and returns that error.
> + *
> + * @s:		the sink
> + * @outlen:	if not NULL, receives the number of output bytes
> + * Return:	0, or a negative error with the reason printed
> + */
> +int sink_finish(struct stream_sink *s, u64 *outlen);
> +
> +/**
> + * sink_abort() - release the sink of a stream that did not complete
> + *
> + * Output already written stays where it is; this drops the buffered ta=
il.
> + *
> + * @s:		the sink
> + */
> +void sink_abort(struct stream_sink *s);
> +
> +#endif /* __STREAM_SINK_H */
> diff --git a/lib/Kconfig b/lib/Kconfig
> index e23037f1e9c..e7eaae5e5aa 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -998,6 +998,14 @@ config ZSTD_LIB_MINIFY
>  =20
>   endif
>  =20
> +config STREAM_SINK
> +	bool "Write a stream to a block device"
> +	depends on BLK
> +	help
> +	  Write data piece by piece as it arrives, for example from wget,
> +	  to a block device. Memory use does not grow with the data: the
> +	  sink needs only its write buffer.
> +
>   config SPL_BZIP2
>   	bool "Enable bzip2 decompression support for SPL build"
>   	depends on SPL
> diff --git a/lib/Makefile b/lib/Makefile
> index 925cb619807..db14b8804ee 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -91,6 +91,7 @@ obj-$(CONFIG_$(PHASE_)ASN1_DECODER_LEGACY) +=3D asn1_d=
ecoder.o
>   obj-$(CONFIG_$(PHASE_)ZLIB) +=3D zlib/
>   obj-$(CONFIG_$(PHASE_)ZSTD) +=3D zstd/
>   obj-$(CONFIG_$(PHASE_)GZIP) +=3D gunzip.o
> +obj-$(CONFIG_$(PHASE_)STREAM_SINK) +=3D stream_sink.o
>   obj-$(CONFIG_$(PHASE_)LZO) +=3D lzo/
>   obj-$(CONFIG_$(PHASE_)LZMA) +=3D lzma/
>   obj-$(CONFIG_$(PHASE_)LZ4) +=3D lz4_wrapper.o
> diff --git a/lib/stream_sink.c b/lib/stream_sink.c
> new file mode 100644
> index 00000000000..b675712531e
> --- /dev/null
> +++ b/lib/stream_sink.c
> @@ -0,0 +1,189 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Write a stream to a block device
> + *
> + * The input arrives in pieces of any size, and memory use does not dep=
end
> + * on the size of the data.
> + */
> +
> +#include <blk.h>
> +#include <log.h>
> +#include <malloc.h>
> +#include <memalign.h>
> +#include <part.h>
> +#include <stream_sink.h>
> +#include <u-boot/schedule.h>
> +#include <linux/errno.h>
> +#include <linux/kernel.h>
> +#include <linux/math64.h>
> +#include <linux/string.h>
> +
> +struct stream_sink {
> +	u64 outlen;
> +	/* first error of sink_write(), returned by every later call */
> +	int err;
> +
> +	struct blk_desc *dev;
> +	lbaint_t blk;
> +	/* first block past the target area */
> +	lbaint_t end;
> +	u8 *wbuf;
> +	size_t wbuf_size;
> +	size_t fill;
> +};
> +
> +static int sink_blk_flush(struct stream_sink *s)
> +{
> +	lbaint_t blocks =3D DIV_ROUND_UP(s->fill, s->dev->blksz);
> +
> +	if (!blocks)
> +		return 0;
> +	if (s->fill % s->dev->blksz)
> +		memset(s->wbuf + s->fill, 0,
> +		       blocks * s->dev->blksz - s->fill);
> +	if (blocks > s->end - s->blk) {
> +		log_err("sink: output does not fit in the target area\n");
> +		return -ENOSPC;
> +	}
> +	if (blk_dwrite(s->dev, s->blk, blocks, s->wbuf) !=3D blocks) {
> +		log_err("sink: write error at block " LBAF "\n", s->blk);
> +		return -EIO;
> +	}
> +	s->blk +=3D blocks;
> +	s->fill =3D 0;
> +	schedule();
> +
> +	return 0;
> +}
> +
> +static int sink_blk_write(struct stream_sink *s, const u8 *buf, size_t =
len)
> +{
> +	size_t n;
> +	int ret;
> +
> +	while (len) {
> +		if (s->fill =3D=3D s->wbuf_size) {
> +			ret =3D sink_blk_flush(s);
> +			if (ret)
> +				return ret;
> +		}
> +		n =3D min(len, s->wbuf_size - s->fill);
> +		memcpy(s->wbuf + s->fill, buf, n);
> +		s->fill +=3D n;
> +		s->outlen +=3D n;
> +		buf +=3D n;
> +		len -=3D n;
> +	}
> +
> +	return 0;
> +}
> +
> +static void sink_free(struct stream_sink *s)
> +{
> +	free(s->wbuf);
> +	free(s);
> +}
> +
> +int sink_blk_area(const char *ifname, const char *dev_part, u64 offs,
> +		  struct blk_desc **dev, lbaint_t *start, lbaint_t *count)
> +{
> +	struct disk_partition info;
> +	u64 skip;
> +
> +	if (strpbrk(dev_part, ":#")) {
> +		if (part_get_info_by_dev_and_name_or_num(ifname, dev_part, dev,
> +							 &info, 1) < 0)
> +			return -ENODEV;
> +	} else {
> +		if (blk_get_device_by_str(ifname, dev_part, dev) < 0) {
> +			log_err("sink: no device %s %s\n", ifname, dev_part);
> +			return -ENODEV;
> +		}
> +		info.start =3D 0;
> +		info.size =3D (*dev)->lba;
> +	}
> +
> +	/* a broken partition table must not wrap the block math below */
> +	if (info.start >=3D (*dev)->lba || info.size > (*dev)->lba - info.star=
t) {
> +		log_err("sink: %s %s lies outside the device\n", ifname,
> +			dev_part);
> +		return -EINVAL;
> +	}
> +	if (offs % (*dev)->blksz) {
> +		log_err("sink: offset %#llx is not a multiple of the block size %#lx\=
n",
> +			offs, (*dev)->blksz);
> +		return -EINVAL;
> +	}
> +	skip =3D div_u64(offs, (*dev)->blksz);
> +	if (skip >=3D info.size) {
> +		log_err("sink: offset %#llx is past the end of %s %s\n",
> +			offs, ifname, dev_part);
> +		return -EINVAL;
> +	}
> +	*start =3D info.start + skip;
> +	*count =3D info.size - skip;
> +
> +	return 0;
> +}
> +
> +struct stream_sink *sink_to_blk(struct blk_desc *dev, lbaint_t start,
> +				lbaint_t count, size_t wbuf)
> +{
> +	struct stream_sink *s;
> +
> +	if (!wbuf || wbuf % dev->blksz) {
> +		log_err("sink: write buffer %#zx is not a multiple of the block size =
%#lx\n",
> +			wbuf, dev->blksz);
> +		return NULL;
> +	}
> +	if (!count || start + count < start || start + count > dev->lba) {
> +		log_err("sink: blocks " LBAF "+" LBAF " are outside the device\n",
> +			start, count);
> +		return NULL;
> +	}
> +
> +	s =3D calloc(1, sizeof(*s));
> +	if (!s) {
> +		log_err("sink: out of memory\n");
> +		return NULL;
> +	}
> +	s->wbuf =3D malloc_cache_aligned(wbuf);
> +	if (!s->wbuf) {
> +		log_err("sink: no memory for a write buffer of %#zx bytes\n",
> +			wbuf);
> +		sink_free(s);
> +		return NULL;
> +	}
> +	s->dev =3D dev;
> +	s->blk =3D start;
> +	s->end =3D start + count;
> +	s->wbuf_size =3D wbuf;
> +
> +	return s;
> +}
> +
> +int sink_write(struct stream_sink *s, const void *buf, size_t len)
> +{
> +	if (!s->err)
> +		s->err =3D sink_blk_write(s, buf, len);
> +
> +	return s->err;
> +}
> +
> +int sink_finish(struct stream_sink *s, u64 *outlen)
> +{
> +	int ret =3D s->err;
> +
> +	if (!ret)
> +		ret =3D sink_blk_flush(s);
> +	if (outlen)
> +		*outlen =3D s->outlen;
> +	sink_free(s);
> +
> +	return ret;
> +}
> +
> +void sink_abort(struct stream_sink *s)
> +{
> +	sink_free(s);
> +}
> diff --git a/test/lib/Makefile b/test/lib/Makefile
> index 9fc4a1a9b5d..af099777391 100644
> --- a/test/lib/Makefile
> +++ b/test/lib/Makefile
> @@ -8,6 +8,9 @@ obj-$(CONFIG_$(PHASE_)UT_COMPRESSION) +=3D compression.o
>   ifeq ($(CONFIG_XPL_BUILD),)
>   obj-y +=3D abuf.o
>   obj-y +=3D alist.o
> +ifeq ($(CONFIG_SANDBOX)$(CONFIG_STREAM_SINK),yy)
> +obj-y +=3D stream_sink.o
> +endif
>   obj-$(CONFIG_ECDSA_VERIFY_MBEDTLS) +=3D ecdsa.o
>   obj-$(CONFIG_EFI_LOADER) +=3D efi_device_path.o efi_memory.o
>   obj-$(CONFIG_EFI_SECURE_BOOT) +=3D efi_image_region.o
> diff --git a/test/lib/stream_sink.c b/test/lib/stream_sink.c
> new file mode 100644
> index 00000000000..a39cf010743
> --- /dev/null
> +++ b/test/lib/stream_sink.c
> @@ -0,0 +1,137 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Tests for writing a stream to a block device
> + */
> +
> +#include <blk.h>
> +#include <part.h>
> +#include <stream_sink.h>
> +#include <u-boot/uuid.h>
> +#include <test/lib.h>
> +#include <test/test.h>
> +#include <test/ut.h>
> +
> +#define DATA_LEN	3000
> +
> +static void fill(u8 *buf, size_t len, unsigned int seed)
> +{
> +	while (len--) {
> +		*buf++ =3D seed;
> +		seed =3D seed * 43 + 17;
> +	}
> +}
> +
> +/* Feed @len bytes of @src in pieces of @piece bytes. */
> +static int feed(struct stream_sink *s, const u8 *src, size_t len,
> +		size_t piece)
> +{
> +	size_t done, n;
> +	int ret;
> +
> +	for (done =3D 0; done < len; done +=3D n) {
> +		n =3D min(piece, len - done);
> +		ret =3D sink_write(s, src + done, n);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +/* Give mmc2 two partitions, as test/cmd/rw.c does. */
> +static int setup_partitions(struct unit_test_state *uts,
> +			    struct blk_desc **desc)
> +{
> +	char guid[UUID_STR_LEN + 1] =3D "";
> +	struct disk_partition parts[2] =3D {
> +		{ .start =3D 48, .size =3D 8, .name =3D "data" },
> +		{ .start =3D 56, .size =3D 16, .name =3D "log" },
> +	};
> +
> +	ut_asserteq(2, blk_get_device_by_str("mmc", "2", desc));
> +	if (CONFIG_IS_ENABLED(RANDOM_UUID)) {
> +		gen_rand_uuid_str(parts[0].uuid, UUID_STR_FORMAT_STD);
> +		gen_rand_uuid_str(parts[1].uuid, UUID_STR_FORMAT_STD);
> +		gen_rand_uuid_str(guid, UUID_STR_FORMAT_STD);
> +	}
> +	ut_assertok(gpt_restore(*desc, guid, parts, ARRAY_SIZE(parts)));
> +
> +	return 0;
> +}
> +
> +static int lib_test_sink_blk(struct unit_test_state *uts)
> +{
> +	u8 src[DATA_LEN], back[4096];
> +	struct blk_desc *desc, *dev;
> +	lbaint_t start, count;
> +	struct stream_sink *s;
> +	u64 outlen;
> +
> +	ut_assertok(setup_partitions(uts, &desc));
> +	fill(src, sizeof(src), 2);
> +
> +	/* the whole device, with a byte offset, also as hardware partition 0 =
*/
> +	ut_assertok(sink_blk_area("mmc", "2", 0x400, &dev, &start, &count));
> +	ut_asserteq_ptr(desc, dev);
> +	ut_asserteq(2, start);
> +	ut_asserteq(desc->lba - 2, count);
> +	ut_assertok(sink_blk_area("mmc", "2.0", 0, &dev, &start, &count));
> +	ut_asserteq(0, start);
> +	ut_asserteq(desc->lba, count);
> +
> +	/* a partition by number and by name */
> +	ut_assertok(sink_blk_area("mmc", "2:1", 0, &dev, &start, &count));
> +	ut_asserteq(48, start);
> +	ut_asserteq(8, count);
> +	ut_assertok(sink_blk_area("mmc", "2#log", 0x200, &dev, &start,
> +				  &count));
> +	ut_asserteq(57, start);
> +	ut_asserteq(15, count);
> +
> +	ut_asserteq(-EINVAL, sink_blk_area("mmc", "2:1", 0x100, &dev, &start,
> +					   &count));
> +	ut_asserteq(-EINVAL, sink_blk_area("mmc", "2:1", 8 * 512, &dev,
> +					   &start, &count));
> +	ut_asserteq(-ENODEV, sink_blk_area("mmc", "9", 0, &dev, &start,
> +					   &count));
> +	ut_asserteq(-ENODEV, sink_blk_area("mmc", "2:7", 0, &dev, &start,
> +					   &count));
> +
> +	/* 3000 bytes into "log", a 1 KiB buffer; the tail block is padded */
> +	memset(back, 0xff, sizeof(back));
> +	ut_asserteq(sizeof(back) / 512, blk_dwrite(desc, 56, 8, back));
> +	ut_assertok(sink_blk_area("mmc", "2#log", 0, &dev, &start, &count));
> +	s =3D sink_to_blk(dev, start, count, 1024);
> +	ut_assertnonnull(s);
> +	ut_assertok(feed(s, src, sizeof(src), 7));
> +	ut_assertok(sink_finish(s, &outlen));
> +	ut_asserteq(DATA_LEN, outlen);
> +	ut_asserteq(sizeof(back) / 512, blk_dread(desc, 56, 8, back));
> +	ut_asserteq_mem(src, back, DATA_LEN);
> +	ut_assert(!memchr_inv(back + DATA_LEN, 0, 3072 - DATA_LEN));
> +	ut_assert(!memchr_inv(back + 3072, 0xff, sizeof(back) - 3072));
> +
> +	/* an aborted stream leaves the buffered tail unwritten */
> +	memset(back, 0xff, sizeof(back));
> +	ut_asserteq(sizeof(back) / 512, blk_dwrite(desc, 56, 8, back));
> +	s =3D sink_to_blk(dev, 56, 8, 1024);
> +	ut_assertnonnull(s);
> +	ut_assertok(feed(s, src, 1500, 1500));
> +	sink_abort(s);
> +	ut_asserteq(sizeof(back) / 512, blk_dread(desc, 56, 8, back));
> +	ut_asserteq_mem(src, back, 1024);
> +	ut_assert(!memchr_inv(back + 1024, 0xff, sizeof(back) - 1024));
> +
> +	/* "data" is 4 KiB: the flush of the fifth KiB fails */
> +	s =3D sink_to_blk(dev, 48, 8, 1024);
> +	ut_assertnonnull(s);
> +	ut_assertok(feed(s, src, sizeof(src), sizeof(src)));
> +	ut_asserteq(-ENOSPC, feed(s, src, sizeof(src), sizeof(src)));
> +	ut_asserteq(-ENOSPC, sink_finish(s, NULL));
> +
> +	/* the write buffer must be a multiple of the block size */
> +	ut_assertnull(sink_to_blk(dev, 48, 8, 1000));
> +
> +	return 0;
> +}
> +LIB_TEST(lib_test_sink_blk, UTF_DM | UTF_SCAN_FDT | UTF_CONSOLE);
>=20

