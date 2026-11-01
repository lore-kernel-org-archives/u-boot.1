Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124EA606A330
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 21:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=E6720lmi;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.com header.i=boogiepop@gmx.com header.a=rsa-sha256 header.s=s31663417 header.b=OCFcboqV
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E241D40513;
	Sun,  1 Nov 2026 21:31:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CZCm9Sl1HkAi; Sun,  1 Nov 2026 21:31:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0A43A404F5
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793568665;
	b=HTOayJbwDRMeq2rAUczy7WmfopYpixROW0BvqlBegRiOX3lGvL5qt39kUst5h1JeO+4l
	 BoXVC28yhWTu7zLapOmCDAl6YVtG+hTzaaZ+RGV0Y0e+LyJP2BAiVjzZs6wuhtRmVZJ7v
	 6uI8tMPe2dNfT8gYgIYQMYs4akHwNGrfk0jR2gBoqqYIiZDRH7dV1viyU+h53k8YFp/Xi
	 uNxmtYOit7zeaRRl+SL5Sr20VVVdZxYCLOEk/7ava01qsY6nYu6IEtC/CnX04LiNhdWae
	 UkU6PlmMeMi8iI9VXH14siaF9rErm82H2wEVMvwhHavZ6vl8ifAgL9R4rp0k9VBA66g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793568665;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Provags-ID:
	 UI-OutboundReport:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=RDdG0e6p98oJlDo9jhyCbPyW/tJv8k2l8V+bAUkzHZE=;
	b=ed7ONJiznjNMOfFCojIgs+J/g4Wc13uh2sElD3ixTypdh32Xt/Rc4LElHPon7QtAiHCE
	 SEEH+jqLr9sh7R2KQZYuzNIRStisPLBmjPsfnDg4kwtSM8yOEkYmzDmREhlMw/7OFtqEI
	 eEFXlPpoeVUS6UQc+IzgobbTGN1IGLfkHMiXaxij075A02ZWVWn52AQfwFD2CxZ6tUiji
	 ue64NlEtGgo808kgwRoe+f4+54cHY8QFOAGzDJlXnABQ6WVKrKegFsSK9pX0XCwaFZd2g
	 hlIBNahWT/cEhL8CTL9/oejUATH+3/l9qYwlRzN9CH0ievKFRgr0iJTPFpYQnPemHbQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793568665;
	bh=RDdG0e6p98oJlDo9jhyCbPyW/tJv8k2l8V+bAUkzHZE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E6720lmitVz8OiHtnSTpbDhl8p613myDeywO6Kk5mwdJIVsD+DMa4Cq9uheudvl+r
	 71a48YkIXQJ/N6SE70PXLwL770Z3MZHxZYTZp8WJE1YGg7Dxc3i8npc3DkTx5lKKbH
	 I5+elBw1cJ2R8TShqaDYC6puBZfz37ogl9DLDS+JYHRc2Ymu5EsOYnGT9KHJ1BBXpc
	 09XudebN3nGJgkBh8NhNBUXPlOBSBPGIh1z8xtWJzoF0HqDEl9huYWg0wgSkvFa6NN
	 B6XAlZwTw9dXNRzHsGnMzvR8uIlTZOifT2ItWHIxIwgwVmRzKhGO9aPFfdl49xSbUG
	 6XQfC3rDfImiQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0A43A404F5;
	Sun,  1 Nov 2026 21:31:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 99C082AC
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:31:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8B51940042
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:31:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zgHQS167-b93 for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 21:31:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E4BC940079
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=212.227.17.21
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793568660;
 b=gz20wxZHQf6mMXa/iWX0JfaT2aUO+siBQzs4/3T2q5NYT3TOfYjcjL3c474FdnhQ0Fw/
 C8YkGXgjY6AmlSPHcFQugj6NoBEoZAgaeQLtvN03ePCl7+aVMm4Xpj181yP2EqhBO1Bov
 B4a0XSOzSxnjB9BN4nBg1bdf6fSk4ylk88D+exKIIudcqmSYnqhdAY7ldY+Tfpbvl5nps
 ba/rofxCRIvLDrItnAId1LC6IFcmswh4Ay1p9fgnDWbuD6lWrMrf2mbIBEJcW3kg4d6Jc
 BblFVFyHThx0SPOAibj/aRXUMOyvSHs0ZOvCUCtDfQQLHIeQBTWHytm8jj8nvMrRe1g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793568660;
 h=Received-SPF:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
 bh=RDdG0e6p98oJlDo9jhyCbPyW/tJv8k2l8V+bAUkzHZE=;
 b=bTk3XF6Ii7ICU493MTinngNXOp0b0++0J0Z2mRsEoh4lRb6Nw8HODwavAZVuDHfuvVuS
 0YLe6Jb2DrFRU496O8wrpMwMsU1fRTQ28kJ6aAxkITvSa0J/oGVq6iSskpWlYQ7u0tivS
 zxk0/PxkKR8OiD2iyRm8b9AcUjnvrf9Pfx33EAE/Cj9AntaIFwgAZ1C6N5aLYQr3sLDFn
 jSQZr8qMHJgXL0cxSWn+McmH6XbTCsxMmicZO6DTaw0bnp3fxaOCTD8mmjoUQkr95I0Dv
 kbaLSB8+AujLpHFNrQiGDb/sWHc2U7NfPwUAaYOSJXgD5LUwEhio6+2EBVerwFJ0O2w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmx.com;
 dkim=pass header.d=gmx.com header.i=boogiepop@gmx.com header.a=rsa-sha256
 header.s=s31663417 header.b=OCFcboqV; 
 arc=none smtp.remote-ip=212.227.17.21
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.17.21;
 helo=mout.gmx.net; envelope-from=boogiepop@gmx.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmx.com header.i=boogiepop@gmx.com header.a=rsa-sha256
 header.s=s31663417 header.b=OCFcboqV
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E4BC940079
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
 s=s31663417; t=1793568651; x=1794173451; i=boogiepop@gmx.com;
 bh=RDdG0e6p98oJlDo9jhyCbPyW/tJv8k2l8V+bAUkzHZE=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=OCFcboqVpvmgTWpZD5t++qbeFhrN3XNNzXqVtZ09FfqcI/ViZpNkDNIPXJGc9hwi
 XNbxUvKdvFXAlB320ws+uxIVkhi7OpzOnrVF2/KnkVgsFhZCuq5kq/ePRcSOfPY+G
 eMkVn9k3OXveCNtsS8IChv2DI5uOmGA51YKjm2z6Mp4Bh5nfr21wUfgkBG1pDa+BU
 KFe99gYQP2wVgalYi05cC0ERsyRfjNqsm5P5NjjBHHAylqki8JeU7xnd7yamVAGkH
 ndb52ClAcyTtiOwSnGIC7pUnXVW9MbDf/iku39+AhUVhExh5Wp7OZT+6BQcgH7CFa
 XzRv4qsS+GUsTVbsbA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MsYqp-1wY7yj3FVb-010dDG; Sun, 01
 Nov 2026 22:30:50 +0100
Message-ID: <25797f8a-40c4-406a-84f0-a494e73bc5cc@gmx.com>
Date: Sun, 1 Nov 2026 22:30:49 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: rawnand: rockchip_nfc: set mtd->dev instead of
 writing through NULL
To: =?UTF-8?B?WWFsw6fEsW4gQ2Fu?= <ylcncn@gmail.com>,
 u-boot@lists.u-boot-project.org
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Kever Yang <kever.yang@rock-chips.com>, Quentin Schulz <u-boot@0leil.net>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20261030073705.164572-1-ylcncn__22449.7708653629$1793365203$gmane$org@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?H=C3=BCseyin_BIYIK?= <boogiepop@gmx.com>
In-Reply-To: <20261030073705.164572-1-ylcncn__22449.7708653629$1793365203$gmane$org@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZRB+GiCogTCQXJ+vliRSs8UyDXpRzWRRSX0qBoCZPogmBERyZnA
 5XUc2uqrM70t7A0DIkMWsZ3uGB32krXsBCUVf7EDbHs7Klb1ef6jOOQ/VTB24Dlyh6obr+k
 NMFzNi8DwNjFMR9DBV229dQN7NibXAECORiCR40Hlu0XdJMQ0OwBUf3Sk436yeG/OuEtQk+
 vbXT3bYz2MngIEwXdioaA==
UI-OutboundReport: notjunk:1;M01:P0:cmx2ckYExPs=;10yIcjdY/s9Wtg5GBOZCcvHBwav
 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
 7QrU7u42rspt1FB8LyxZsR8vOGnTCWsll9
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello Yalcin

I can confirm i had suffered the same problem and this fix works.

However making this exact change reveals another bug in mtdparts.=20
Amazingly it worked with previous null pointer implementation.

Same fix as yours:
https://github.com/hbiyik/u-boot/commit/efd3e40ae90af19de824fb8e5f66bed6e7=
0cf4de

Additional fix then necessary in mtdparts:
https://github.com/hbiyik/u-boot/commit/e238d03fa50f4f46e62ac3eb264f5f8940=
024759

Signed-off-by: H=C3=BCseyin BIYIK <boogiepop@gmx.com>

On 10/30/26 08:37, Yal=C3=A7=C4=B1n Can wrote:
> rk_nfc_nand_chip_init() does `mtd->dev->parent =3D dev`, taken from Linu=
x,
> where the device is embedded in struct mtd_info. In U-Boot mtd->dev is a
> pointer and still NULL at this point, so this writes dev to address 0x18=
.
>=20
> Harmless while address 0 is RAM; on the RK3066 started from the boot ROM=
 it
> is the ROM, and the write ends in an asynchronous external abort.
>=20
> Set mtd->dev to the controller device instead, as other raw NAND drivers
> do.
>=20
> Tested on an MK808B (RK3066) from the NAND ID blocks (H27UCG8T2BTR).
>=20
> Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>
> Signed-off-by: Yal=C3=A7=C4=B1n Can <ylcncn@gmail.com>
> ---
>   drivers/mtd/nand/raw/rockchip_nfc.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mtd/nand/raw/rockchip_nfc.c b/drivers/mtd/nand/raw/=
rockchip_nfc.c
> index d23a651f..c134045d 100644
> --- a/drivers/mtd/nand/raw/rockchip_nfc.c
> +++ b/drivers/mtd/nand/raw/rockchip_nfc.c
> @@ -948,7 +948,12 @@ static int rk_nfc_nand_chip_init(ofnode node, struc=
t rk_nfc *nfc, int devnum)
>  =20
>   	mtd =3D nand_to_mtd(chip);
>   	mtd->owner =3D THIS_MODULE;
> -	mtd->dev->parent =3D dev;
> +	/*
> +	 * mtd->dev is still NULL here: `mtd->dev->parent =3D dev` (from Linux=
, where dev is embedded)
> +	 * wrote to address 0x18. Harmless only while 0 is RAM; on RK3066 star=
ted from the boot ROM
> +	 * (soc_remap =3D 0) it is the ROM, and the write ends in an asynchron=
ous external abort.
> +	 */
> +	mtd->dev =3D dev;
>  =20
>   	nand_set_controller_data(chip, nfc);
>  =20

