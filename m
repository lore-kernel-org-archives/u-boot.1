Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FF5606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 04:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zBOJPpvB;
	dkim=pass (2048-bit key, unprotected) header.d=ausil.us header.i=@ausil.us header.a=rsa-sha256 header.s=google header.b=HpBKLbWF
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 589F14058C;
	Wed, 28 Oct 2026 04:47:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZfFGU_QcFjST; Wed, 28 Oct 2026 04:47:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5A7DD40586
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793162836;
	b=tB5Q/54T+3Z7A/BNjDFr+7IRCLexIQV02eTqflVkZWO9hzrlWz/Bw5wqkgfehSjG/Cv/
	 V2PtC0fEWm4Hq9fT9ax5HU8WpgWSae9VhPB23MGAJ0JQLIyibXdEeJxxR9GwDAK3A8Cu6
	 lHcQtIfSxtdqWh+drJXj20Jfg3FrqR5nw7wH43hxt6cZ8HbtsUq+pPIBa1Q6EW7RX0ROt
	 +uvaHPKFBZkwmIlw5ALCzkgv4GmTkVvstZgJ28/ZVfFfgT9d7dy7sBt6tqVJDjbDtTleg
	 pIqkIy7g4O+DBqhblHzQZbEU4ee92Ya3XZeu/VZuiztWeDDsk9BaBzs1cqXMMct7agw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793162836;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=OzPK3Wn3sPjBwOPipbs8M2Tx/qhTHfnWoBqnz+M+dnY=;
	b=PU/izHmzD80xwvCtHxiWLvkKdE8OTqUk2cEW35HRGmznvE2EcpJhL/7lkcUm+yOsJ5Zh
	 JtJOVTQ2omlCRc7QyYZ6N2f0jOd6Nxg37O8mir/cadav4zHK0D0hsqiCtMSMPI0iV+Ott
	 3+TtjtKcYGXugJed5D+kbUy67jiw8Em1uZBgKomXvk8FY0xxmbcjWV/e1bZmgTTHiGBu1
	 GKlKVaSdocR2Q3qPlhC95xtVvzHL+maSHhiBhN67zsDPbIUXpdlhNnOqnFqzTVEH0R+g9
	 3NHNYPfG4E3qb7Iyc484toTmjnPM4OCk6r/sCQbqAmrUVnD0IwjucCaEfz9+ojBaBoA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793162836;
	bh=OzPK3Wn3sPjBwOPipbs8M2Tx/qhTHfnWoBqnz+M+dnY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zBOJPpvBeLPQwvbIH+wfVwC9UTR0rlXYjphzhQYqV0k67+sNYbdHRiaLIRlCcqrwb
	 68GNIEDQ8QV0gmpP1wDw6Z1QlxWgqkioFNc0ByzXGdovQxoSavLXoGhJ3tiu+ogAAt
	 IWQjlHi0zg87mF0TjYlN9gnrUpK+EKnCb65pLQCjbw0FmXhLDv0hCtAphww75diJBY
	 iBjNNqkcZnKxbOpIUD4j6+HW9c1cBE7ExjXbVHkyBRT79LNE/YYdsiBDci8aYWm0jT
	 G5Pu4tRu0XOWKEMn1/zPYww7GZHF4513TfU5iK5mK59OU7Biz2hS51V6biBWuy45tk
	 rkCb6JhUQKn7g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5A7DD40586;
	Wed, 28 Oct 2026 04:47:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id BF6B0972
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 04:47:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BCE8580C3D
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 04:47:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id feasL6GrXo8A for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 04:47:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B20CD80C27
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::82a"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793162834;
 b=E8KReZjXVbge/FkAkeEk07Bk3wjVhWCYMOScXGUtK7dPrdg16uvZSA7BRvh92S6WPZzd
 C2CUpfWBryIafMqWHSkM4m+mANWLpJ8/p7yxHom3LW5KQZmt71mLu1ic4wr9aOozPa/gi
 n+EEyUr6l0YZXxXGbsiSpU+fY8VQsuKpNSYnk5jd5SjwQK/re2Vl1Gv5NK7pfwJ1bMBAm
 ghwJ+B4anKqhu1yT3tYTFGSc7Q6kPF8hu/AOH3xvTMgnYgo2ZUozRNWpKzA1ClkxpRf8h
 T+6K3auYai7ULhcxYpS/03Qe7Zj9lXFOOiZOVaul7mrVLUGvYmMvD9C5bn0uImiTncA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793162834;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=OzPK3Wn3sPjBwOPipbs8M2Tx/qhTHfnWoBqnz+M+dnY=;
 b=SEoYo3j4P3xyZG5KuQa7qG1xu3ScmGukhgrHeU9mca+lwRuja5nv+ToRzLHIFTedjre6
 llk4kZvfPGjoYam5zdqCyDt3bZERnBtW3XE508KHhi6yY536AUCjb17PmwaNeGhNyeVLp
 O18964s25vRLr8eHCsmeNoxPQdQTmvevbNIBlnUtSLDaeJbmJp40am3PrLysXUziN/1mD
 ArZs92l8JI/pdPmyvXZh3DmZfkpv+wk5ha9Ov82QzwskVs0l5Ol0a6Mnr+1LiYd+hRq/h
 ICGt7qQ+DPrG+FNw1qRQ4idpBkVV72IrR6LoC8repQgCrl+E7KXKUwf726RU9P5kFNA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=ausil.us;
 dkim=pass header.d=ausil.us header.i=@ausil.us header.a=rsa-sha256
 header.s=google header.b=HpBKLbWF; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::82a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::82a; helo=mail-qt1-x82a.google.com;
 envelope-from=dennis@gilmore.net.au; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ausil.us
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ausil.us header.i=@ausil.us header.a=rsa-sha256
 header.s=google header.b=HpBKLbWF
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B20CD80C27
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 04:47:12 +0000 (UTC)
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-53669f7b518so8327421cf.2
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 21:47:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793162832; cv=none;
 d=google.com; s=arc-20260327;
 b=NxbigQiZE1VEfXHVtKZLvsC1ZRV/5oQlKxWmaZ0VA/6dBJS3Fvc2FrxGDFM4KyikLq
 eCBZ0HckzH+4BRkd2yf4UhMZF3s/hHIdpXd4NlWLlr3NmdhYVzBcfGQDG/FsR75kqovc
 CN1MeimkJ1g/5Rg5fWklFnF7CvrhJkJhFDPCtiPJHg/sRfWDBpzVJgfyD8YlaILdLTaK
 3H7Qp62EkeekorNUS6ew7znZagsLKkTwmT1Wfpvgvhkg6oPkSC6SBHR/gO9Yc3/lYmvI
 bE+C8JUvu+PKt8dI8E5ANc0rqOk1MPeuwque3cJNEHje7KdmWaa/HmxdIRLOliAfF2mU
 m+GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=OzPK3Wn3sPjBwOPipbs8M2Tx/qhTHfnWoBqnz+M+dnY=;
 fh=cPGd9t9nY8j+/0ZDpaItMlmRDuw21WSQn2qtx37Tr9U=;
 b=UsdmFn8SFVONyi/rzIuqUBnqHzwKH82QBxjt+VXYax6O+7cErr7rV8PMMIa8dI8fHR
 ubxtbDoZvej+dhXxUHgq0uSH0xQhd3A+gjKFFnnBZ60f6qbqALbai+PLC7n0pTsaPS0W
 qDd/wPl4W4zaWKzzDG2R4EY39c6ZS1gQ05YvlXf4elQbqlRkL6hYTmzLJAiw2Wj70B3G
 rzgcDp0Dc11mw1R1Z9UOi+N8Fwbsj8Rgake9+6CKK1b+xlvmYvzlGMqJr35lRnHWDFoX
 4NDz8/MfBFBNSXCmnrbUXwbuOxcZkbRE4JqHDdxIus+QUOV7X0uuif4WIyJqJ5QCHHqP
 Uz/w==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ausil.us; s=google; t=1793162832; x=1793767632; darn=lists.u-boot-project.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OzPK3Wn3sPjBwOPipbs8M2Tx/qhTHfnWoBqnz+M+dnY=;
 b=HpBKLbWF5PltiuyJdOllsbqaKKLUB2ph0RvTx0AEc+ujURF21hiyz2IJoKz6z7rtB9
 QtJZIZIaJ8w57O/N6MsSBRp3+v4enxyVEnLaonSQKFXI/GXEgom26xlAW5ReJtEeTNZK
 4kQPU9IfkoxIFt+L0pZOuHJApxnGOUXeJTqJpzWkXizS99Ch77MpGbEgKx5LvnnDXSrv
 UofpMTzvzMeepTxA99Gp3xLGMqT15QrXCi41CmOQgaaJPeaQOSjIl9874yTsTy/CLJKv
 nQgBVp0whD60sokeJ6W8KG9RtKwJvuk2l4WO41om34QxVRhKdodaoqYwM5MMIR96i7U/
 VaRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793162832; x=1793767632;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OzPK3Wn3sPjBwOPipbs8M2Tx/qhTHfnWoBqnz+M+dnY=;
 b=OQv/LlA3lJ6WBtOssTBTKQ+c79kGEIhXDtXuuiOFDjJ4ZPZyvAY0+ZrmvU7QKBdYNC
 j5MN+7bxffpBkkkV507wiwhDs9Byk/PHnX1lzdcIi6Hm9GD1YtlYxBsjVGgUirciyIxq
 Byj/GYAfj3DLuu5zwbN4CQ2UIILWRGwdcrmsA07NiWvvbHG/XarXGrRa8G4dI5IIpPfe
 bCsJaQcYAF4t9yM0xNKHBBnCIvpydHpPFfPhT37DJcK2clilAyBNE3Z2muhPxVariCMa
 6qWYKAqxBoAT4gpY2Ng3QI0GMGZftW/JF+GDEBRB5sF3ospx0wtVE3KNq8RdgGa+SUx5
 VhBw==
X-Gm-Message-State: AFq9FYJ3NGRKI31X0t344O+ZGk2ywEwKiu7Cy7DOafw2BUE4yDxUnbcR
 1j1JKrsLUwUhD4THJkcRAIxUF2zm9atTPD8xc/3LeM7Wc2FgC6mkNkxrXQiY37m10u3HDnMyjqM
 QJrfq9sftxSPFC6cLhlr6yiB9CxH23XHx0Y31PQymyw==
X-Gm-Gg: AYBFou3+puf9epM+aiIIJ4cWqgtaOmFv5koSEmWEKhRDC2wvpxaco+LI95ffX1I4oDW
 460eRd+5PDd3BA9fFiy/eGRJ+m2E0DRHuFEPuhauByszYcOkAEUViCyNE3Q5t1jVbKVo/JZfVM2
 h2MgXfuyASGMvF6ZYtmbP7e4786v5ot5yP3SWx+sE3r3p5mIqHuzPOXRrThJ8cM+W2so102HrhG
 S4ctUzRhMf+vp1YivDltsyy70Ke7r4rImKDqDt/Uiv4WiHD7vXonbtzhid6z5ljCCTTqwX2zK2w
 0/sAW6USOeXbXCBuqCrrDEE6wzz9GZf2FLaG1jB2sJGzfFCRXi6pl3XsRjxtq88rbKEiZzSaNBt
 jdJuMLiJpAreGHVDTZB/4evHZduwQZgLMsu0hoTnpKfTDZcYueBFLjY6qf9U8ilGXc0FBGBBZpL
 c+ajh/Ac/AjchUAGt7y2dPnkg=
X-Received: by 2002:a05:622a:1828:b0:536:55c7:a1d7 with SMTP id
 d75a77b69052e-53fcc6cce41mr23814651cf.54.1793162831690; Tue, 27 Oct 2026
 21:47:11 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261012020134.621305-1-dennis@ausil.us>
 <20261012020134.621305-6-dennis@ausil.us>
 <a8ccf1c4-2979-4b20-86dc-9d089ee86126@0leil.net>
In-Reply-To: <a8ccf1c4-2979-4b20-86dc-9d089ee86126@0leil.net>
From: Dennis Gilmore <dennis@ausil.us>
Date: Tue, 27 Oct 2026 23:46:59 -0500
X-Gm-Features: AclHuK9LriS7L-PzDX-INDJpRKSIxI7Bk-NPlhSjv1R_7X0W3fEA29VZTP2to10
Message-ID: <CAABkxwsOUMN4kvqpEtimWGmz+m+v_iTTXMknoVrFLFw2GedF_g@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] board: rockchip: Add Xunlong Orange Pi 5 Pro
To: Quentin Schulz <u-boot@0leil.net>
Cc: u-boot@lists.u-boot-project.org, Kever Yang <kever.yang@rock-chips.com>, 
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Alexey Charkov <alchark@gmail.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 12:17=E2=80=AFPM Quentin Schulz <u-boot@0leil.net> =
wrote:
>
> Hi Dennis,
>
> On 10/12/26 4:01 AM, Dennis Gilmore wrote:
> > The Xunlong Orange Pi 5 Pro is a single-board computer based on the
> > Rockchip RK3588S SoC. The board provides many interfaces, including
> > two HDMI output ports, a PCIe-attached Motorcomm YT6801 1GbE port,
> > an M.2 M-Key slot, one USB 3.0 and four USB 2.0 ports.
> >
> > Features tested on an Orange Pi 5 Pro 16GB:
> > - SD-card boot
> > - eMMC boot
> > - PCIe/NVMe
> >
> > The devicetree is taken from Linux v7.3 via the preceding dts/upstream
> > picks.
> >
> > The upstream devicetree muxes the PERST# pin of pcie2x1l1 and
> > pcie2x1l2 to the controller's dedicated function while also using it
> > as reset-gpios. Linux switches the pin to GPIO when it is requested,
> > U-Boot does not, and probing pcie2x1l2 then hangs. Override the
> > pinctrl in the -u-boot.dtsi to use GPIO function for the reset pins,
> > like rk3568-rock-3a-u-boot.dtsi does, until the Linux devicetree is
> > fixed.
> >
> > Link: https://lore.kernel.org/linux-rockchip/20261002025746.3284691-1-d=
ennis@ausil.us/
> > Signed-off-by: Dennis Gilmore <dennis@ausil.us>
> > Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
> > ---
> >
> > Changes in v2:
> > - Add Link to the Linux devicetree PERST# fix (Quentin)
> > - Move MAINTAINERS entry into alphabetical order (Quentin)
> > - Add Jonas as reviewer in MAINTAINERS (Jonas)
> > - Drop USE_PREBOOT/PREBOOT (Quentin, Jonas)
> > - Drop DISPLAY_BOARDINFO_LATE, Model and SoC were printed twice (Jonas)
> > - Drop OF_SPL_REMOVE_PROPS, use the default (Quentin)
>
> I meant to only drop clock-names from OF_SPL_REMOVE_PROPS, not the whole
> OF_SPL_REMOVE_PROPS.
>
> Do you mind if I apply this patch with
>
> CONFIG_OF_SPL_REMOVE_PROPS=3D"interrupt-parent assigned-clocks
> assigned-clock-rates assigned-clock-parents"
>
> added to the defconfig (I'll mention the change made in the commit log)?
> This would be consistent with the other more recent Rockchip defconfigs.
>
> Note that the first 4 commits are now unnecessary as Tom has merged v7.3
> Device Tree into the main branch.
>
> Cheers,
> Quentin

Hi Quentin,

I am not at all opposed to that

Dennis
