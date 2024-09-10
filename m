Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8C0DEDE994
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 02:44:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F21C288EC1;
	Tue, 10 Sep 2024 04:44:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="nBjaTzxT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B87B288EE0; Tue, 10 Sep 2024 04:44:02 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A445188EB5
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 04:44:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1725936225; x=1726541025; i=xypron.glpk@gmx.de;
 bh=05RUgJwi+W0T4bC9fdRtE2SZosmPjNet2CVkLYNNvBQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:Cc:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=nBjaTzxTz/fG5LfctVHlSed5sfkZuqvcnoN/CP4Nc5MGMmCJJxhfIpSFikzPmARH
 P+os4McQJzwpWReT5TEjtfIEJ49BlgJcRDsNc6De/xb1NSUS2Y5hhDaPiIbYpOjMq
 Mc7QUbZyFQt4AvbI2BqnHcCeyzE9we5bZfIWKTXwAuJGskQt0cTQnd3jvv82U3ybt
 gu55RfRlC8g5SKGnCbWWEYpA6idd4X3EQ2r6THmcQtiPLX9BmvJklraJLxI09oR0h
 4YKE6Ug70jxxa57BPT0wMYsHL5rPKjsyV6QMsjUQdnSThM3aJDGta5OzkNInX6MYh
 4/hMUy5ivC7BSHIfLw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.160.200]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYvY8-1safYG3bf6-00Upcf; Tue, 10
 Sep 2024 04:43:45 +0200
Message-ID: <ede30554-41eb-4197-adb6-75ad24eda159@gmx.de>
Date: Tue, 10 Sep 2024 04:43:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v2 3/3] cmd: mtd: add nandtest command support
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
References: <20240909222113.2562703-1-mikhail.kshevetskiy@iopsys.eu>
 <20240909222113.2562703-4-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Michal Simek
 <michal.simek@amd.com>, Francis Laniel
 <francis.laniel@amarulasolutions.com>, Anand Moon <linux.amoon@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, u-boot@lists.denx.de
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240909222113.2562703-4-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:S4pb8acGh0i9EF2HRkkGvc5CSelk013qbz6KmEQuIuviFS9ZPsU
 oRT1d/78FASl1ZhWlXikdglKAtLICSytzIsIOlyz1t+w85fbiJuA9o0thjWIB3hVYjIDQu4
 s4u3viykYQqBd2YQD0oFD53hsbecq0Gx3NwXOua+QuZXu5gGwsd9d1Ykme/bJCLugo5f4/K
 k8VYKtmYv0uTQO5d3/k1w==
UI-OutboundReport: notjunk:1;M01:P0:uDa6wCeGlP8=;t6Qm8nIG+09e/uFEv3pMEfuKs5k
 C178SDLC8GXpUbiyPFVPYw+zhzePLqHxyzmknCKVO1avc14DKihbNKEfLsGoLy56uE97QZlXA
 zffhU36Ly/47rYMtzhpsjzPLJqVXcYgfvgdljbDdqHVrOqPomJu1QDcJzKZKYtBDdiVLJ+H/N
 ew2Orkvp0Sla9Yd7dTW1ws497cFLN3dUzgRmhdxcFELCmMKWETL41m/d7wwP+a3PNNE9JFvf9
 ZGvKneDMhBKqhbBVY/W96OL+6rtiBBnQbBNrT1w6vxW+MjU6Tbp1iAEjMekfFy5ycOMvfqv7b
 hIU8u4mRj1e19bROxYUfe651CNgxWsVf31ti5ctUQd/JdoJJcAbFRRwI+qk6kHhkGf7Nf1mFs
 E0nR1If6XHAOMMxq7TuvC0nNWZuePLQtw0k4ceX8CImWuh0nKAc0l26IHmcKiouvoGFnFvXPz
 cAL4talfpC8xHwWxDMN6W79wh1eJN7E41/E+vL+0MOdR1svAycIElKUb1VRjIeMy2BbVqBOkA
 8YfBFw8Uj1oR1h/XU5jaz1o7Y6fzZPqSyYwM4QSY886LPwDuQT5wu/jhrm6KrHLdndvBEDl8a
 E3v9RIMm2uwYjpoWlqW6RYIiYsvYgDt5AcRfJFQxdjC9dZxHrvsTm/7GVWwCNTGYuNlVWdaXd
 trc6vEB3xb3tO0GnkHGAhgZx88Fg7vlgN/fGVIGz74wnge5B9wVBb0KQAP5s93n79WrCzF5Le
 BxN75LemeiTvcp9O+6zTcJsMv3zh1x2U9elMWEc+LM/NADxDdSzQSrTM/i8q2xpHMtCb2+pve
 ZUAl6nv3YxWkGy01ljoR+ENg==
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

On 9/10/24 00:21, Mikhail Kshevetskiy wrote:
> This patch implements readonly test of nand flashes.

nits

%s/readonly test of nand flashes/a read-only test for NAND flash devices/

>
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>   cmd/Kconfig |   6 ++
>   cmd/mtd.c   | 203 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 209 insertions(+)
>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 698e0e697f2..db5113e016b 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -1445,6 +1445,12 @@ config CMD_MTD_TORTURE
>   	help
>   	  MTD torture command support.
>
> +config CMD_MTD_NANDTEST
> +	bool "mtd nandtest"
> +	depends on CMD_MTD
> +	help
> +	  MTD nandtest command support.
> +
>   config CMD_MUX
>   	bool "mux"
>   	depends on MULTIPLEXER
> diff --git a/cmd/mtd.c b/cmd/mtd.c
> index 69ddfe1d9c6..4a380dcaf83 100644
> --- a/cmd/mtd.c
> +++ b/cmd/mtd.c
> @@ -931,6 +931,202 @@ out_put_mtd:
>   }
>   #endif
>
> +#ifdef CONFIG_CMD_MTD_NANDTEST
> +enum nandtest_status {
> +	NANDTEST_STATUS_UNKNOWN =3D 0,
> +	NANDTEST_STATUS_NONECC_READ_FAIL,
> +	NANDTEST_STATUS_ECC_READ_FAIL,
> +	NANDTEST_STATUS_BAD_BLOCK,
> +	NANDTEST_STATUS_BITFLIP_ABOVE_MAX,
> +	NANDTEST_STATUS_BITFLIP_MISMATCH,
> +	NANDTEST_STATUS_BITFLIP_MAX,
> +	NANDTEST_STATUS_OK,
> +};
> +
> +static enum nandtest_status nandtest_block_check(struct mtd_info *mtd,
> +						 loff_t off, size_t blocksize)
> +{
> +	struct mtd_oob_ops	ops =3D {};
> +	u_char			*buf;
> +	int			i, d, ret, len, pos, cnt, max;
> +
> +	if (blocksize % mtd->writesize !=3D 0) {
> +		printf("\r  block at %llx: bad block size\n", off);
> +		return NANDTEST_STATUS_UNKNOWN;
> +	}
> +
> +	buf =3D malloc_cache_aligned(2 * blocksize);
> +	if (buf =3D=3D NULL) {
> +		printf("\r  block at %llx: can't allocate memory\n", off);
> +		return NANDTEST_STATUS_UNKNOWN;
> +	}
> +
> +	ops.mode =3D MTD_OPS_RAW;
> +	ops.len =3D blocksize;
> +	ops.datbuf =3D buf;
> +	ops.ooblen =3D 0;
> +	ops.oobbuf =3D NULL;
> +
> +	if (mtd->_read_oob)
> +		ret =3D mtd->_read_oob(mtd, off, &ops);
> +	else
> +		ret =3D mtd->_read(mtd, off, ops.len, &ops.retlen, ops.datbuf);
> +
> +	if (ret !=3D 0) {
> +		free(buf);
> +		printf("\r  block at %llx: non-ecc reading error %d\n",
> +		       off, ret);
> +		return NANDTEST_STATUS_NONECC_READ_FAIL;
> +	}
> +
> +	ops.mode =3D MTD_OPS_AUTO_OOB;
> +	ops.datbuf =3D buf + blocksize;
> +
> +	if (mtd->_read_oob)
> +		ret =3D mtd->_read_oob(mtd, off, &ops);
> +	else
> +		ret =3D mtd->_read(mtd, off, ops.len, &ops.retlen, ops.datbuf);
> +
> +	if (ret =3D=3D -EBADMSG) {
> +		free(buf);
> +		printf("\r  block at %llx: bad block\n", off);
> +		return NANDTEST_STATUS_BAD_BLOCK;
> +	}
> +
> +	if (ret < 0) {
> +		free(buf);
> +		printf("\r  block at %llx: ecc reading error %d\n", off, ret);
> +		return NANDTEST_STATUS_ECC_READ_FAIL;
> +	}
> +
> +	if (mtd->ecc_strength =3D=3D 0) {
> +		free(buf);
> +		return NANDTEST_STATUS_OK;
> +	}
> +
> +	if (ret > mtd->ecc_strength) {
> +		free(buf);
> +		printf("\r  block at %llx: returned bit-flips value %d "
> +		       "is above maximum value %d\n",
> +		       off, ret, mtd->ecc_strength);
> +		return NANDTEST_STATUS_BITFLIP_ABOVE_MAX;
> +	}
> +
> +	max =3D 0;
> +	pos =3D 0;
> +	len =3D blocksize;
> +	while (len > 0) {
> +		cnt =3D 0;
> +		for (i =3D 0; i < mtd->ecc_step_size; i++) {
> +			d =3D buf[pos + i] ^ buf[blocksize + pos + i];
> +			if (d =3D=3D 0)
> +				continue;
> +
> +			while (d > 0) {
> +				d &=3D (d - 1);
> +				cnt++;
> +			}
> +		}
> +		if (cnt > max)
> +			max =3D cnt;
> +
> +		len -=3D mtd->ecc_step_size;
> +		pos +=3D mtd->ecc_step_size;
> +	}
> +
> +	free(buf);
> +
> +	if (max > ret) {
> +		printf("\r  block at %llx: bitflip mismatch, "
> +		       "read %d but actual %d\n", off, ret, max);
> +		return NANDTEST_STATUS_BITFLIP_MISMATCH;
> +	}
> +
> +	if (ret =3D=3D mtd->ecc_strength) {
> +		printf("\r  block at %llx: max bitflip reached, "
> +		       "block is unreliable\n", off);
> +		return NANDTEST_STATUS_BITFLIP_MAX;
> +	}
> +
> +	return NANDTEST_STATUS_OK;
> +}
> +
> +static int do_mtd_nandtest(struct cmd_tbl *cmdtp, int flag, int argc,
> +			   char *const argv[])
> +{
> +	struct mtd_info		*mtd;
> +	loff_t			off, len;

These variables should use the same type as the field size in struct
mtd_info to avoid overflows, i.e. u64.

> +	int			stat[NANDTEST_STATUS_OK + 1];
> +	enum nandtest_status	ret;
> +	size_t			block_size;
> +
> +	if (argc < 2)
> +		return CMD_RET_USAGE;
> +
> +	mtd =3D get_mtd_by_name(argv[1]);
> +	if (IS_ERR_OR_NULL(mtd))
> +		return CMD_RET_FAILURE;
> +
> +	if (!mtd_can_have_bb(mtd)) {
> +		printf("Only NAND-based devices can be checked\n");
> +		goto out_put_mtd;
> +	}
> +
> +	off =3D 0;
> +	len =3D mtd->size;
> +	block_size =3D mtd->erasesize;
> +
> +	printf("ECC strength:     %d\n",   mtd->ecc_strength);
> +	printf("ECC step size:    %d\n",   mtd->ecc_step_size);
> +	printf("Erase block size: 0x%x\n", mtd->erasesize);
> +	printf("Total blocks:     %d\n",   (u32)len / mtd->erasesize);

Please, use do_div() for the division instead of truncating len. Cf.
mtd_is_aligned_with_block_size().

> +
> +	memset(stat, 0, sizeof(stat));
> +	while (len > 0) {

A for loop using the struct mtd_info fields would be easier to read:

for (u64 off =3D 0; off < mtd->size; off +=3D mtd->erase_size) {


> +		if (mtd_is_aligned_with_block_size(mtd, off))
> +			printf("\r  block at %llx ", off);

How could you arrive at a value of `off` which is not aligned to the
erase size?

If you could get to such a value, why would you continue?

Best regards

Heinrich

> +
> +		ret =3D nandtest_block_check(mtd, off, block_size);
> +		stat[ret]++;
> +
> +		switch (ret) {
> +		case NANDTEST_STATUS_BAD_BLOCK:
> +		case NANDTEST_STATUS_BITFLIP_MAX:
> +			if (!mtd_block_isbad(mtd, off))
> +				printf("\r  block at %llx: should be marked "
> +				       "as BAD\n", off);
> +			break;
> +
> +		case NANDTEST_STATUS_OK:
> +			if (mtd_block_isbad(mtd, off))
> +				printf("\r  block at %llx: marked as BAD, but "
> +				       "probably is GOOD\n", off);
> +			break;
> +
> +		default:
> +			break;
> +		}
> +
> +		off +=3D block_size;
> +		len -=3D block_size;
> +	}
> +
> +out_put_mtd:
> +	put_mtd_device(mtd);
> +	printf("\n");
> +	printf("results:\n");
> +	printf("  Good blocks:            %d\n", stat[NANDTEST_STATUS_OK]);
> +	printf("  Physically bad blocks:  %d\n", stat[NANDTEST_STATUS_BAD_BLOC=
K]);
> +	printf("  Unreliable blocks:      %d\n", stat[NANDTEST_STATUS_BITFLIP_=
MAX]);
> +	printf("  Non checked blocks:     %d\n", stat[NANDTEST_STATUS_UNKNOWN]=
);
> +	printf("  Failed to check blocks: %d\n", stat[NANDTEST_STATUS_NONECC_R=
EAD_FAIL] +
> +						 stat[NANDTEST_STATUS_ECC_READ_FAIL]);
> +	printf("  Suspictious blocks:     %d\n", stat[NANDTEST_STATUS_BITFLIP_=
ABOVE_MAX] +
> +						 stat[NANDTEST_STATUS_BITFLIP_MISMATCH]);
> +	return CMD_RET_SUCCESS;
> +}
> +#endif
> +
>   static int do_mtd_bad(struct cmd_tbl *cmdtp, int flag, int argc,
>   		      char *const argv[])
>   {
> @@ -1019,6 +1215,9 @@ U_BOOT_LONGHELP(mtd,
>   #endif
>   #ifdef CONFIG_CMD_MTD_TORTURE
>   	"mtd torture                           <name>        [<off> [<size>]]=
\n"
> +#endif
> +#ifdef CONFIG_CMD_MTD_NANDTEST
> +	"mtd nandtest                          <name>\n"
>   #endif
>   	"\n"
>   	"With:\n"
> @@ -1060,6 +1259,10 @@ U_BOOT_CMD_WITH_SUBCMDS(mtd, "MTD utils", mtd_hel=
p_text,
>   #ifdef CONFIG_CMD_MTD_TORTURE
>   		U_BOOT_SUBCMD_MKENT_COMPLETE(torture, 4, 0, do_mtd_torture,
>   					     mtd_name_complete),
> +#endif
> +#ifdef CONFIG_CMD_MTD_NANDTEST
> +		U_BOOT_SUBCMD_MKENT_COMPLETE(nandtest, 2, 0, do_mtd_nandtest,
> +					     mtd_name_complete),
>   #endif
>   		U_BOOT_SUBCMD_MKENT_COMPLETE(bad, 2, 1, do_mtd_bad,
>   					     mtd_name_complete));

