Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A45C606A31C
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 02:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FVpyl4CT;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=djTbzQsv
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E215080F86;
	Tue, 10 Nov 2026 02:09:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T9xJeW2OiVLg; Tue, 10 Nov 2026 02:09:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 31E4B80F1B
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794276566;
	b=sJ/FiFjE9zZ1HNBC10AbiKiXBwaOUfB+IH07chbp34qI5KPYA3feOuMPbE+ShaDlywuD
	 dHbpeAAbpjDhyqz1sdwb2ep5wSccPLZod7ZNg30rPI3upMTnzzapNoUdrvBZdv7lF8Kjr
	 VFJeUmTDrZSWMdmHJ1ICVLMoL+0THMXAviQQMSaPCBclxA3aJbU4afdMz0s6N8tgBOEFu
	 e2O5LhIwOtnqsVsZ0eKU+boIwRZeexLkW+rPz5mBRVg2/+GWuv9k70fKHL/FJ0lJjWg41
	 ARfxDrzZkSD0wx1r5Qv4ZEcWZ+wAsZW6inJfbgVO1guHaY3HiuvOz+5Q7+xMeWU8L6w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794276566;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=NZDJD12xnb47cId5Kunld/132ysdVAaEhG+E5ePN39U=;
	b=T+YuPzMpkI4RqsiGNBnJv0fqT9D8u46j1FAsmWbyDh96Jd4U8CbvfENLbSmp/o7NuFtA
	 7CewZ2AqTV7E0JSHDWZK5ztwoSYoJjychiDU8IDG/y5SqrCucGBYJboAtyc4Ju7GS09c/
	 CIVRDzNSfn8g2S+KlqseQUrgiaoPW9j45kq8RRFTsGfzgz3f/rM1EM5k05dkHcnXs65ry
	 wTqjGEXrxO7xsDl/nqoV4Dw2V91R9CDRIBJLQJX5xLmBi84ggbSKNRC0TtPGT5LrRRu/J
	 90K/fP6BU9s4d5b95FD/nisILtY29ocpI98IF3HU9xF5rn6X8AvhqZT6fLTU+xpJbLQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794276566;
	bh=NZDJD12xnb47cId5Kunld/132ysdVAaEhG+E5ePN39U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FVpyl4CTaxfkLEtMOi+SkmoD+4DyvSSG4blYi2JM4jpAkSw1WxtYW+WhqxUASspgs
	 1UxWWx6WizfYCNqneJ+ZAZTl6ZDcHhxLQVqCn1JwSaxLi9AgFxuaDx+kgLG0b4QI5O
	 4XJQqMs3zGgflZx2+VTMU4p2076NYXH/cpmGyMar4MF6fCCZd4s0jo3DmTvj30g4zf
	 lrDk5kixJkvJrMu41sM+nIn44J51FEnHba1Okbp/Vek8LzD1HYGyzmC9WeuHQsrnDW
	 sZPcWjdEKZJ3fBlukDlnb6/JWAQeNZZ4/hHsu3L/eoMzxsmwKP6KYwpznAGmZPxaoW
	 0QXK1Y2oqKEhQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 31E4B80F1B;
	Tue, 10 Nov 2026 02:09:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1E2A4CC4
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 02:09:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0E95660790
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 02:09:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PkPT5PXJaj7p for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 02:09:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 12C736070F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::234"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::234; helo=mail-lj1-x234.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=djTbzQsv
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 12C736070F
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 02:09:23 +0000 (UTC)
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-3adfcafaabbso14213511fa.3
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 18:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794276561; x=1794881361;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NZDJD12xnb47cId5Kunld/132ysdVAaEhG+E5ePN39U=;
 b=djTbzQsvbZPvklOQAHbn2u8wq+PpZjZyMoldAjwDetbBOysWab5XxwJCwrpcpVKnR3
 WNC4FFgllCi1xmKAzyfhAf6y1UTY05CIjy8HZcGe/RBMNWTQQiSDJgwSZUQvlXcLXn1e
 tz0SLDORTXBzinascr8OkHvyUabmbs7IwrIgFNSw3X2KY5W8p3azgn1k4AXjvfsS5kgh
 JYgC8qH1vqbPQPHR3l0PzS8rHiWjDq5nwxT7nZxY5KrE/R742N8RAslGrGz+q1jYXZOf
 SBnbvjrRkXNTyqMk55fM4VwwK3tDQoWY3dUkAn4fSyQOahqJH2Q8eOUnr17N7pGWyvyR
 q67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794276561; x=1794881361;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NZDJD12xnb47cId5Kunld/132ysdVAaEhG+E5ePN39U=;
 b=0vXnFoU/aEx/QxP8GKxS6ZJfIqfGqaaSOZlKxMvvfrWM08onGWJLBbmQ1ez4HVEALA
 15t3b9bJT7JquVObaN3SrOUzRt+zDz+CS93faB4KnyeWuicPUpg/fZ/LMCxzdbTWtBYP
 E7RR5OY0aBQhKbpLPzZEcHWZquHi6kl0QRd3NUO3ZSK22cCaToUj5S+hWndFuU0flVu/
 HVVmTik9ZS+Xm1BGvAR+WxkTZuabKDaOErCLT094nsScot6zVgGvSnvO9RtNEafszvvb
 Tp8dIdVR5UgByCBDXi62SWchT1AWPAZDAGC0gZVciAm7Impkt6ZEVGSYFFOil2TDZB3I
 wZdQ==
X-Gm-Message-State: APuU4Z/qinYqqY+P6f9LCd/PuorCBncFhKOUDNe06jBWzP3FzqUdW4AX
 t+dMKxkvzUVGuvU25CcDRuLDkf2BRv9HGO0z7fGN9E5DBhivGG7Puj1YxtB7aZDjh/+zl39WudZ
 xLua+gTkP1P2rjsYsfTbfyDMbOF7A9Bc=
X-Gm-Gg: AYBFou2wehHCYAetavngW6rCOwZSanFEOGSM8CkaPIyFMg8M3q0/KqTzt61G9DaboHh
 GbSqZx19UFh5Fj2j9BBtQZrmns2S3Z+nk4xEcytKPsSpGr2O9pz+zYUB3UVtRR2oAgIPNebhJID
 QOLAf8S6k+nZHxo0HB8hd74WUKdw5UK8JMgWhMriHewyPdDe8Zh5yQBLs75OH3Uz3vtPeXt7jJe
 aHDBzOuQ0rDXwt/byuLXe6+eR4f7DQIkq3Gzxzj9zEfXKvIuFH+JyHIXeRW1Hh45sYDAb1j/d7k
 riojWj6rlA3pGUm8Y6CrnVGBTbUqRx52OgHb4hkAdzbJsf7Oo+xaMiODxxETq9fndmR0NiX5RDF
 Vdg3S9GWLy+6re+yHLC5CyDj5yskaC52UYYMLWRiyo9BYKRJIQqOPHzc9tO9j2HyMsvf5pf4yAP
 4Hou4c7zSm/RqnAua3BO2MiRNIoA==
X-Received: by 2002:a05:6512:2249:b0:5be:4ab6:b23f with SMTP id
 2adb3069b0e04-5c156ecabafmr322765e87.61.1794276561014; Mon, 09 Nov 2026
 18:09:21 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260902163748.1003274-1-marex@nabladev.com>
 <a6365f6f-b87c-4d6a-8be3-c315931bf36b@nabladev.com>
In-Reply-To: <a6365f6f-b87c-4d6a-8be3-c315931bf36b@nabladev.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 9 Nov 2026 23:09:09 -0300
X-Gm-Features: AclHuK866dS5-l-q0IRl-lVMeYUnsdlkWDOEzaAbwdYTKN6QNb6fCBn3iKBWrWg
Message-ID: <CAOMZO5B=PRD-miBT8HASshW5FaStdVGXDx9Vxbnw19z9Afwzjg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx: Switch Data Modul i.MX8M eDM SBC to
 OF_UPSTREAM
To: Marek Vasut <marex@nabladev.com>
Cc: u-boot@lists.u-boot-project.org, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Marek,

On Mon, Nov 9, 2026 at 10:42=E2=80=AFPM Marek Vasut <marex@nabladev.com> wr=
ote:

> Hello Fabio,
>
> have you had a chance to pick this patch ?

For some reason, I didn't find it in Patchwork, but I have just
downloaded it from the list, and it applies cleanly.

It will be part of my next pull request to Tom.

Sorry about that.
