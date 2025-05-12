Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E104DC3ABCB
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 21:50:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61FB380C83;
	Mon, 12 May 2025 23:50:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZBUZXsqy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6CCD82162; Mon, 12 May 2025 23:50:29 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF3DC80584
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 23:50:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-549b116321aso5669620e87.3
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 14:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747086627; x=1747691427; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bBIEMT3BVC9SiNDpMT5UfcPzgwekV2bf6Sg5tpdIAqE=;
 b=ZBUZXsqya69KqxXR00bq+wVLe2flcQqAAoLc/lZPi3nlNsbs5laIgggV902izyNXsj
 sBYMuHZvV0MIJQz12mX8RpPMNj5y5ly2lJlmj/t15/ohIBPEiJZZfShMV1hPs/R99Dxq
 /CD+tfXZEnf1soJAoUor5zUhzSu/7Inb5w2xNnN+10swwQa7+t3VElkkEMElO5I5Zq9X
 LrT0a2YkHdfE9UwL9fyOpsdmHh1O+ifgSXC4CKIeMhVhidNf9RN7MkaSXDtCqrYXhjOP
 B/bpAWC+jhrH+591uoIo3Je5u7nOez+xsvJxOHHUFwlADs/ozVuqVeUclkx3Jzuwk2Nm
 DCog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747086627; x=1747691427;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bBIEMT3BVC9SiNDpMT5UfcPzgwekV2bf6Sg5tpdIAqE=;
 b=qAIZL9GZarM6IjFYk28qdSXtQ1Lle5jwy21R7VzMNFVnKOjYMY/C+sLOx2RhF8cFST
 DqxOehZAI/sbVGvnP6u+mi0VUeNgT8kf3Pv9LNOoK94bePn40X0QW9+B/tTqEdH9Gcz5
 9JnzbOrjUp1sn1OWtX+uP5jEHQBIea1ldVUH6DBxJ7sRrZF8vy8DE5iOLMtEHT41b4pN
 +BIZSI4+Mu/jtEzi5TLmIJNvWRk7Jvcy6ysFw/wv3o6rOxyJmSorHTGXx4a/hXQTQoQl
 C/hgV6Hn89sxryGlUtjW26fMVHXmLLkxQhY5mgqeMdjG2/YFIRU1I57HXeCbQCY3HO7X
 dSpA==
X-Gm-Message-State: AOJu0YyjV74n8pNdO+pEAl1QMoEBM/G9PqeOot15mIhrgxo2BCm7BOqq
 6emlefxukyMuXHRwNr60wCLkcj9j0zYmvr9nhB1SXD1E+Sapqqu+yXKKudQhwLCYpIJrh9nmox8
 J9wNlfaSuPz9jP8uWlCo2VAFBZZtLVw==
X-Gm-Gg: ASbGnct0tDUuAKzgRiw07k+m7NJGJN2mwTQHt9+KVAZ4kj+wYt7jrmEsNsiy5iub6Y3
 SQyYRosZZ+6e7Rnr+FPRqatSVddUnUgy7oInGd54lghJ49eOEF6SpMIpAaXRRDXQpCIMb8FjYft
 0SQ7Z4kGL0tCdosaUmj7h0FXWbnMcu2cHgiVkmK9wkhiqKjhsJTZOozpXTlPodGv/2
X-Google-Smtp-Source: AGHT+IFqKdy1BYTy2mCsyjk6tnBVJUPE6reNeq7H+9SNUaQFwWeUfhwDEur7r0AL//Otgr2sBIkDrTV3h6JoDP+Xx4o=
X-Received: by 2002:a05:6512:6408:b0:54e:a2f8:73e2 with SMTP id
 2adb3069b0e04-54fc67c47damr4622051e87.18.1747086626718; Mon, 12 May 2025
 14:50:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250505213733.4114398-1-tharvey@gateworks.com>
In-Reply-To: <20250505213733.4114398-1-tharvey@gateworks.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 12 May 2025 18:50:15 -0300
X-Gm-Features: AX0GCFuS6wjxz4UOjOcH0TCVJ7Qy4AK0B_tf_fv_txdgEHec9xRt-Tf_J4jC9tQ
Message-ID: <CAOMZO5A8XsUVbi7MO+Xa-cDMWwea0yF+oTE3dCQGcY9mDmeLZQ@mail.gmail.com>
Subject: Re: [PATCH] imx95_evk: enable PCI early
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Alice Guo <alice.guo@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
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

On Mon, May 5, 2025 at 6:37=E2=80=AFPM Tim Harvey <tharvey@gateworks.com> w=
rote:
>
> Enable PCI early as the NETC device is an PCI ECAM device.
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied, thanks.
