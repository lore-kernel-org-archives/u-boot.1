Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BDC8D79767
	for <u-boot@archiver.kernel.org>; Sat, 31 Jan 2026 12:38:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4D48844F1;
	Sat, 31 Jan 2026 13:38:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dSkrghTX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3065684535; Sat, 31 Jan 2026 13:38:03 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF25C844C7
 for <u-boot@lists.denx.de>; Sat, 31 Jan 2026 13:38:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-59e0d5c446cso3553378e87.0
 for <u-boot@lists.denx.de>; Sat, 31 Jan 2026 04:38:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769863080; cv=none;
 d=google.com; s=arc-20240605;
 b=JlXte56J5YEk13T6HsuCcw40GWzU2Byd4B8/k6d1Eufra/mz5nQiJMyM3gKo0wm9PS
 zDZPkB4lkh5o5Od1FP+rrrg6I/PGATI35jEiD95Pu8qoY6u7dGcaj7wBJRjMtEg5W5gU
 5r4KFglLSVu4Ez4CNeyYraX3+LlfH8jYOlMuoCi+rbtLn1XMdyFSKw326n1zQ7urIb+0
 jIXlqEdm5uYJYu17wxI8B8oOD5C6ujXFwjfqxbHoqglcj4F2G3zbbRyXme5URb+WAjYw
 GfmfJEQf4msV2+4ASlo4hZdfSxB1undkp39LGEc1IixqRF9jcNWeTTsDMeRXIb+ZSWsy
 jjVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=flShb7r7wBD/RBu8kcSVZu72CAedNHDUkOmz+wtCTD0=;
 fh=N7bds302uY9F/ZHEMbR/T2BqYrLtYzBgHhRmVzEkUyA=;
 b=GRv3r03Ngyu+5VujHCjn7q63Kl0D34jnQPpV/0nd1JxsfJLP6f44yPjN4Rjrl0k+QD
 EwAA7N62xnORIxPFg8oQrlqI4VMoG6E2+XP5rV+2gLMFW11KnwRcJhWkO88b1NC88vZn
 4OUw7Q6xV20H6hu62vP6wiT7uDs6na7g8x31agmR6NFK8ItIepzs5PZAym0E/owCwHRB
 t/+qvnKErovBHr9PlJbSR5zCz7jEhSqSDEXQLJAysWFA2vtxKtYaBO+e7KDRXgpBrOyz
 GcJRMa2hG2rkvWV8SY+/cgM3c5mpmdum4n0oqH7yydZXLmJ90i7gG3PUrjURPt8pK9jD
 zOPg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769863080; x=1770467880; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=flShb7r7wBD/RBu8kcSVZu72CAedNHDUkOmz+wtCTD0=;
 b=dSkrghTXnVeckyFG1lIy1EtQanzVyTMMQth6PcBhQBnrxUhEDfiGSTVdNK/BInLSSE
 Mb5y8wHXuwgNQlyhim+yLvMaWKRaCayNXlJ5HPyM+U87U2nuIjAal7zb2hs3xQNVHGyI
 MlSKAFGwEm31oKcbt0rFD5hvWVk2ZzTWki3emAv20DBM3j/BeOgP5WeYJvdZvhVnF+9W
 mFvDt7ZFo4WbXz92FKylVsBQJH29eSYCVKDUuK/m/fpSTr00bqL7lW7H+U50xM5f+WUe
 qms+HnU4nlbFPchPOV7lpKc4d9PWMEUk/dbJ8HGzI61FmcIAwYoiLplEltin2OxkoPdc
 fSAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769863080; x=1770467880;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=flShb7r7wBD/RBu8kcSVZu72CAedNHDUkOmz+wtCTD0=;
 b=mxKYzVAaCYeeLEX0EAmAkbyQKkpvtrYGqdfhkFz1WqfNeWOSH/zI4yRqn0j4mEpr+E
 92CLIWfAyMATPVG//ssfK5mrswDkalUNObvsmlcDFfJUNAEZUJqz09GnFE+B+h5rYpuj
 vaDOJ1ItWL+887dv2JQW/ttatCOzIFeQQ+P/kWhTtuPxzBHt01sgYKoi66y6ovn6syJ7
 swM6TveNFTCYQvMtPtYqL6iKWeMMujMK8teHcLrqP5S8E6/O0nIg1nERxD5BKFsWjdLq
 7h2mhpE15T1qSnL/0rJ16AUdP/bIwwUVdQHxFilKbrKzthSgiWKGCdZBqBFYSgeNSAVC
 XkbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGI3DwOhflQm22/0YLVylbXLZQ0476rCAZSfckYwXZzzpTxF0h83kkawgVHa2Pe4BFkBADiXo=@lists.denx.de
X-Gm-Message-State: AOJu0YwSjruHRtXJkYGq2xXuRrDqw/Kz9+1RlcwJmuwnSRvxbRuN9bMz
 xtx6FhpjwOQAqr/vudlTXCmV/uX2Bz1NGTDdDk/UIPlDidmLFpEMPA233htrUVF6mn8r+38NfXc
 mvZAnDqffRXRmWivhkg5zAU6c6ktpXzc=
X-Gm-Gg: AZuq6aLlTBNutleh51AczfrTLlFqssqB2y9rpTvGaLEjCV9aQfofPCPHlPemIn6AuzC
 rw6XkXOHaddIIRe5r4BdddSB4AZ82hfsYUyp+emDVYdwa2HKpFZRgNgoVA90yOfhjmtwqhDX28j
 +YGidqxF4Y8KYWVSQw/BPfP/x5t9AJ2j4xzlnGrmJv0V6bofXwrwKACNSMLUdNkROq54cdeu3vO
 nImX2Ne009Y/aHQbI484vbsrvHQuAX2tGQ2JnKP1P8oX3Xlglqg5f3n24VYqHyghj3lSSmaDDGd
 vWHvVqYm3cBte70vvCqOWSNQn4Q=
X-Received: by 2002:ac2:4e0d:0:b0:59e:45b:a30f with SMTP id
 2adb3069b0e04-59e164420a9mr2607959e87.39.1769863079708; Sat, 31 Jan 2026
 04:37:59 -0800 (PST)
MIME-Version: 1.0
References: <20260129-imx95-rproc-v1-0-035b2dbf3e57@nxp.com>
 <20260129-imx95-rproc-v1-4-035b2dbf3e57@nxp.com>
 <20260129100133.GA30853@francesco-nb>
 <PAXPR04MB84591087BC940470B1AC0227889FA@PAXPR04MB8459.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB84591087BC940470B1AC0227889FA@PAXPR04MB8459.eurprd04.prod.outlook.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 31 Jan 2026 09:37:48 -0300
X-Gm-Features: AZwV_QgE05ij0ZGM4FWcBRLu-RXFxG6Qh9q8VPjcScN3YDYGhht9e4_hRacRth0
Message-ID: <CAOMZO5BfbmqsWUAbeSCoL1bnQf87UsKJGA-ZDewJiDTRHyfBfQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] imx9: Kconfig: Enable remoteproc for i.MX95 EVK
To: Peng Fan <peng.fan@nxp.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
 "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, 
 dl-uboot-imx <uboot-imx@nxp.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Stefano Babic <sbabic@nabladev.com>, Ye Li <ye.li@nxp.com>,
 Alice Guo <alice.guo@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Peng,

On Thu, Jan 29, 2026 at 11:06=E2=80=AFPM Peng Fan <peng.fan@nxp.com> wrote:

> Fabio,
>
> What's your opinion here?

We should only add "select" in the board or SoC Kconfig if the option
is vital for booting.

The remoteproc options do not fall into this category, so placing them
into the defconfig makes more sense.
