Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 603FCD1CDC7
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 09:19:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9A8788F50;
	Tue, 22 Oct 2024 11:19:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=devpi.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=devpi.de header.i=@devpi.de header.b="TSHBW9I9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1449088F8E; Tue, 22 Oct 2024 11:19:47 +0200 (CEST)
Received: from smtp052.goneo.de (smtp5.goneo.de [IPv6:2001:1640:5::8:30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A961388F4B
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 11:19:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=devpi.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lehmanju@devpi.de
Received: from hub1.goneo.de (hub1.goneo.de [IPv6:2001:1640:5::8:52])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by smtp5.goneo.de (Postfix) with ESMTPS id 67A0E240E52;
 Tue, 22 Oct 2024 11:19:44 +0200 (CEST)
Received: from hub1.goneo.de (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by hub1.goneo.de (Postfix) with ESMTPS id 7FA73240560;
 Tue, 22 Oct 2024 11:19:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devpi.de; s=DKIM001;
 t=1729588782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BI/vxBlDasbAsTcXgd96XqxigBK32oUODsynFAKSSBE=;
 b=TSHBW9I9NNcFQZKmfHmQ2raI6D1plwDjQlWemaf446zcDDSt4p87g2ahkR5M0CLP0UOoe5
 DnnWoUEGesiI4l+f0aeEW6EqEyHKUzhN9Gs40qbbUDpFjWBYtUl1q0ZZm/JyLqnuw4hq4K
 7xu+/C7mEpMnhBpYxmHbwFqffVTtv1zfKEJkH7xgBB1ToHwHiLiHzTkDCKNr6UR/P863VN
 Xu+Jz5KjesE0VHELNePxYvSQAHNCJGmmcrXd9iYdmcYllsbFcvPRJdq/yhj+mp9xW0bFBA
 vzcocnyNizYkRin/4vlonQ8pevKzLcxhKlx2Ipc6+b2xTk3PwUmvDIx8c4u4TQ==
Received: from smtpclient.apple (uhh-wlan-fo-134-100-17-56.rrz.uni-hamburg.de
 [134.100.17.56])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by hub1.goneo.de (Postfix) with ESMTPSA id 432822402D7;
 Tue, 22 Oct 2024 11:19:42 +0200 (CEST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Julius Lehmann <lehmanju@devpi.de>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] scsi: fix disk capacity too small by one sector
Date: Tue, 22 Oct 2024 11:19:31 +0200
Message-Id: <2AAED6E9-717D-42DB-A375-AC0793742E71@devpi.de>
References: <20241022033515.GA3053232@bill-the-cat>
Cc: Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de
In-Reply-To: <20241022033515.GA3053232@bill-the-cat>
To: Tom Rini <trini@konsulko.com>
X-Mailer: iPad Mail (22A3370)
X-Rspamd-UID: 188e8e
X-Rspamd-UID: 545208
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



> Am 22.10.2024 um 05:35 schrieb Tom Rini <trini@konsulko.com>:
>=20
> =EF=BB=BFOn Mon, Oct 14, 2024 at 06:06:35PM +0200, Julius Lehmann wrote:
>=20
>> SCSI READ CAPACITY reports the address of the last
>> block and the block size. The total number of blocks
>> is thus last block address plus one.
>>=20
>> ---
>> This patch fixes the disk size reported by scsi. Up until now, the report=
ed disk size is too small by one sector. Read/Write operations on other sect=
ors have not been affected. Trying to partition scsi backed storage via ums h=
as resulted in "storage too small" errors.
>>=20
>> doc: https://linux.die.net/man/8/sg_readcap
>>=20
>> Signed-off-by: Julius Lehmann <lehmanju@devpi.de>
>> ---
>> drivers/scsi/scsi.c | 2 ++
>> 1 file changed, 2 insertions(+)
>>=20
>> diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
>> index 51cacf3479236be6c6ea3e7d15b87e03f10e7f3a..bcdeda95ed1514119057cc679=
74fec465cf5672c 100644
>> --- a/drivers/scsi/scsi.c
>> +++ b/drivers/scsi/scsi.c
>> @@ -309,6 +309,7 @@ static int scsi_read_capacity(struct udevice *dev, st=
ruct scsi_cmd *pccb,
>>             ((unsigned long)pccb->pdata[5] << 16) |
>>             ((unsigned long)pccb->pdata[6] << 8)  |
>>             ((unsigned long)pccb->pdata[7]);
>> +        *capacity +=3D 1;
>>        return 0;
>>    }
>>=20
>> @@ -332,6 +333,7 @@ static int scsi_read_capacity(struct udevice *dev, st=
ruct scsi_cmd *pccb,
>>            ((uint64_t)pccb->pdata[5] << 16) |
>>            ((uint64_t)pccb->pdata[6] << 8)  |
>>            ((uint64_t)pccb->pdata[7]);
>> +    *capacity +=3D 1;
>>=20
>>    *blksz =3D ((uint64_t)pccb->pdata[8]  << 56) |
>>         ((uint64_t)pccb->pdata[9]  << 48) |
>>=20
>=20
> This leads to this failure in CI:
> https://source.denx.de/u-boot/u-boot/-/jobs/926468#L288
>=20

thx for the hint. looks like the test might need some updating, since the ex=
pected output has changed. will fix it with the next iteration =E2=80=A6 onc=
e i fixed all the necessary python dependencies to run the test locally

> --
> Tom
> <signature.asc>

Regards
Julius=

