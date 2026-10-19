Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E17ECCF2DA
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 09:44:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 56BFA6075A;
	Mon, 19 Oct 2026 09:44:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5Qg1XT2weHlH; Mon, 19 Oct 2026 09:44:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 88D31605FA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792403046;
	b=LBWJtOqnBxUe8ZAEFXjw1CYBdvUCz0iJBtyyzIFcx54MPpxPcm/JFdP7odMYVIhc4Keg
	 ovOmZjx7z25LDZO1ZI/OEA/7Hq+0O79rfmCqIK4+D5faAJTnf10ulsm2UDRzkgoKbZV/N
	 xPhRHJAJJcvdxCG9AgbyL2UpFpBO2JJ3bXHJQboBzbMdQZ+7leW9PCGg2mAZK0jq/2oOd
	 1lFEFLjEfQeWUnwUo5QeNC+ffsAOY5zzplKmNdGFO1gHfeIwtOsH9fIJhlhbHepWNEVNQ
	 li+LXLyrHTFaBtyTVRYYxTA278e3bapJ+491BqaSHatiOcHea1f2vrqphFpHpDte71g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792403046;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=l6/JdI/6B2UgCjVudf2ryZd2RA3MaUzIoywzXi/ohxs=;
	b=MIxT18b2I4Q4H2CWlK7Gw5Q40tbnUusPEM2H0SOg0JgKjnjjGISXHkiye0+qxclhPSOf
	 aQj10n6wRWBROklXhKryFeaI36zrlna0FP5yCeL4wGsE9CNvdzrMHVEqtjyoaJkJqlaGF
	 WmsgsciXBrB29JFt+D8mUdlRiipxwnXw1C7QmN7tWmbnD7hQA21mgpzSYXeb29DQoo5bW
	 VeXoHwxqAHspNcq/JaOqJBR/K9Zp1OZ4Z3kmbTvsPzQ9Jwd0vppa38d6kTJmGIHt05vRq
	 KN2ry9Fq2Q4n35wA4qFpn6XmZoG6PTscS8G04WKlVWMIqONTDiFuR3AzF5FwgI25zpQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=riscstar.com;
	dkim=pass header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=L0fNw2Eq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792403046;
	bh=l6/JdI/6B2UgCjVudf2ryZd2RA3MaUzIoywzXi/ohxs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CxlsDEDNPspzKeNz3I2WY+lE0TvueXa67M5NphP5smd/3Z3h1GE5qqGGMbjKPSE1A
	 sfQn6UW6aSD3U/prmB2eXyu4E2ncEQh8N8/oGY0vu0Y6sZ9HuE4jsP1IVEYs5VlsGl
	 ewsVM5kpVfX1wC+xMmorGGKmuIWTKrznEwuJeixuYfpyE9DUWUgTLMj51IclIpFFhk
	 kH0wiS6KLV4j/7QXhRkPrfEosOa0Jvm8eBhNUt75lsXFSnmBJI4lqwtTzUfO0pfkRj
	 NYwEtXEO7KxoGDFpccBnwZdNwUkGv0D/nlbpZR48Q/T9obR/UOtt6AM8dz86GRlQa1
	 wxZHZKDJSR79Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 88D31605FA;
	Mon, 19 Oct 2026 09:44:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3B3FC2A8
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:44:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 21184605F4
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:44:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3UN2ZY1khKQ2 for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 09:44:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 16217605E3
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::22e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792403044;
 b=DEe/eAD5AzbeIZWk//zFTs/5OuM8BK238ikxvrsE7Ft0Bfc+j6aFxK58AI8WQpJLid7E
 tpGlHokv94FDrUflhVQBSzYktw8DkdEFks5k8YfyYtEMge28DKLZW38iC2GeWBnL6nE3d
 Bi3Sxv/mq33W+6Rew1O9LOhnoMuFgjO59v9X4euLt8qbtcoMrYJnnB6rSeB8ImFLbfqc2
 vhiBY+VRZRxEUH8wklYC6Wc7zRYolj5dGAqAAPZjN1mAYin6fdpvQfjhO+C6Cgx50O/dS
 bsiMjQ5B4AbDbTYg4uBPY5VEbxwoSO/06kO0ZRggAku+s4932lXI58h9Nz/mwxw/Umw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792403044;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=l6/JdI/6B2UgCjVudf2ryZd2RA3MaUzIoywzXi/ohxs=;
 b=CbOHQFT59ptPoPcncam8RN3FcN5ICxfNKOw3HCV3hU+3H8QOUS0LhshIY+vBL7GgY54s
 ODok4T5HZIx52rlUzhCu8/vdWIos3GG/kVTn/xA+HdjKztXj6azSyYqCNakl8b7OWIOvw
 iB8vB/bd4z9kSDXUQ0zl7wYbVll06ZNmbk9aR+BdvEkVtZ2zylFp4J6JtJbCxy9dOh1qf
 Cq0/ZRv5+co46iRbfBaJ81fF/2g+VhUMWJUURKjpogMA/QP16fZ1gBWPOngU/7ME29QNQ
 INhBaw6g8MqF72J+SGRxLc44TWVZQHGeTUJdgiLOyLk+KciY12mtXA+DQ4Hc5YPPSOg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=riscstar.com;
 dkim=pass header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=L0fNw2Eq; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::22e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::22e; helo=mail-lj1-x22e.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=L0fNw2Eq
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 16217605E3
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:44:03 +0000 (UTC)
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-3a9e87ba7f2so12348421fa.1
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 02:44:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792403041; cv=none;
 d=google.com; s=arc-20260327;
 b=kOJximm6Hms4knlCfO76lja3DNlVNJ4PN2ZS5lOzsqHjI8e63MLRAH/Sq+aB/HugQD
 fzEpz56gvr29z0WI8SRNm9GZT08MwMR5PVBXsD3n98KmQ2jTPPiEtcmG3FJr1c59Ow3B
 OSBdvDwn3KK/p2I68R3t34KyMdAFHONiZs3t1j2iVYOPGTCxeH72BkVK4WTbCktu0YWC
 o2I5kbpeTfDZzpvzYUwz+/WN3vHq+GzKyJO/yJn6Ic0HOPdxtLUm5rwiU4/k46TI0kXv
 hDnc9e3o6pgb3uFcNpIWwNBBU1VgrUjaIMKbLY+i5bQP/n75ocyK922W+b4R/5G2MDxD
 L0vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=l6/JdI/6B2UgCjVudf2ryZd2RA3MaUzIoywzXi/ohxs=;
 fh=PssCzfAZagILEbYV0uOcrKn/3Pne2m6Yt2vbWJ+c4C4=;
 b=pIHDmY/BqIBxQBdZOP0eTacLWTzQwWGYi2ioArgNzVJTRgOmk2RXu7qsjhcejTXO8Z
 Dm9ZAMmULsE+BOIK4S0srSFWZ/DPRzk57Gt4uyPHP6MhFkmp4WIoU9enYAzyTdsxzsS7
 V+k1Y8onPDj8XbaF4oTcop7KqoB3dMv/o2oYK4b+nzxeCpVhZEZq6ZduxFqiUT4vDu1o
 qxmklzK/HyZDREerdab/FddmNfUSrisfWS9zAHOO5yMJkvUnQyWOBOqe0FQ1v6QKO8bs
 Zmj9xCfKkKAltJGGtX6CYxrOJ8C8vdwc+s+vT2+iVqmjZVLZUCDJq4UEP0elejqGGpbO
 QuVA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1792403041; x=1793007841;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=l6/JdI/6B2UgCjVudf2ryZd2RA3MaUzIoywzXi/ohxs=;
 b=L0fNw2Eqx+aQ9ONnXs9OibowZGNC5qJRYMqnNjPjEQoE1ms1AEmO3wxcxZC7OmHwCm
 nmV2vL173UFO6MYgK7ZWqHyIkpgKTrfpAUFQM6f0BQ73gUGXddq+GPJlosl1qSSejh5v
 VAQdw2Z+045xSPVA6+7uPFX4WEv8ZoKqsfo5pt5C8UkAo/cdPFs79U33RtJ4l5epXjhD
 DuAYe9vFPa0cXa0IlUthma7bngHp1kqntzIf6+BMhsIfqEkzO4JAZgnxEf2W2Td7+lZT
 Jns9iGo/mTc2Lb3dimggtMBndiBoOvu71r5XP7kP+4fX3S9lVGDI5gpfdJ2syQqiZzOs
 sLXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792403041; x=1793007841;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=l6/JdI/6B2UgCjVudf2ryZd2RA3MaUzIoywzXi/ohxs=;
 b=Q72earVCtBjBq4MtyIHzepygSjrYBbZGbpMxyqaHK3g+djqbgMiGuc+sHGXfIZpEMS
 PWVXOy2fnuLeJb/5rIHATm4zZc5BlHyNSCtDWbcpkW1F3C6LNYxeNzNaUOtfG8TToG7c
 VT+dphTgPq7ieB0lw8k1B0Z6Vu3Faem8+5+J0kQYR5LHTr6LPDxh3TzyktZfNG4YAfDk
 FEFuw/j4/Axmao/Jw8czj5/irSBVxM1FK2zKVStYPmfXJzrSiYihXap09tQ+iPJwBykp
 fNQkYQ/0vm3HEqDlszhxbWhxx5grdSGvGs125dWtngRO7mcepEp7hXr48p5CliaNWsdQ
 m9/Q==
X-Gm-Message-State: AFq9FYJKQD2g7E84e9uesiT/46CbkNxRG5eBa6RbITmMSeR1fNAGwNIp
 3L7YTrZiJE2Bd2Dg63oetHwiAOd9Jq4hF2hUWkXxGuaYYebIQYZkGkv6g8sv5N1X1x4WICYW1nr
 nUVvcjOvHHDw7hYCWJUyIP31+h110gMvef6PZynDzQA==
X-Gm-Gg: AYBFou0A49Kw6+nx6S6Ek1iJnTAi+HFjJ1v65Sr3dWGi11ICmpWjefcigF+w5P7kAJF
 yHIaexaIIxr/4Q9Petz4DpNYkgd5eFHCFyAPw9IcLvp/qE+xhgrFg3uBsh74qyVBEK9rKjvOihO
 uOf25/++PuOPmsrYNbgHM25aL3F3V0BkTqVDX3DCVUQbHhoxqk/UJ0WZoVVJeNFo1eQr12yW+CU
 Up7x7J4supfRYfe7dIAO9iqK7WzeZc49J6n9PySJlk+VXjzlvyzv+W6PyGq+HpXBCTDGQixiaSL
 +C3Jn7T6EJyN/lEjB9wR5Is6n7YVTvXrN6zVRx0miwO95GDVW4JogbvZTrFtIzsYiPc5OmzawId
 dP2Q4cHSdGwB2hbfhepF6nQ6QYWaDpUHw+AwzadjuXxhafPKyv0hOejQaRW6NwhIBRgurdgpwsc
 b3K3osclj6oznb
X-Received: by 2002:a2e:bc23:0:b0:3aa:eb05:2e8a with SMTP id
 38308e7fff4ca-3ab292c6886mr15262361fa.15.1792403041404; Mon, 19 Oct 2026
 02:44:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1790975598.git.DaveWK225@protonmail.com>
 <73651a416255d0af9319f8f3c38c7a1630dedaf8.1790975598.git.DaveWK225@protonmail.com>
In-Reply-To: <73651a416255d0af9319f8f3c38c7a1630dedaf8.1790975598.git.DaveWK225@protonmail.com>
From: Eric Chung <eric.chung@riscstar.com>
Date: Mon, 19 Oct 2026 17:43:49 +0800
X-Gm-Features: AclHuK9hEk58bTjjdDd-npuw8jKFQa5BXVzvHB3RJPQY6ztnmpr_jl2XZoJ9s7w
Message-ID: <CAH22mJxLrduPZHf=KcJTDSPG4jEZJKvubfK7fRR9Xu3Ly+_7Fg@mail.gmail.com>
Subject: Re: [PATCH 8/9] pci: spacemit: set the link width from num-lanes
To: Dave Klotz <DaveWK225@protonmail.com>
Cc: u-boot@lists.u-boot-project.org, Huan Zhou <pericycle.cc@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Yixun Lan <dlan@kernel.org>, 
 Tom Rini <trini@konsulko.com>, u-boot-spacemit@groups.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Sat, Oct 3, 2026 at 5:31=E2=80=AFAM Dave Klotz <DaveWK225@protonmail.com=
> wrote:
>
> The driver never reads the standard "num-lanes" property, so a board
> cannot set the width of a port: the OrangePi RV2's M.2 slot on port B
> is wired for two lanes, and other boards may use only one of the two.
>
> Linux's DesignWare core reads "num-lanes" and, when it is set,
> programs the port link mode, the link width and speed control register
> and the Maximum Link Width in Link Capabilities from it, leaving the
> hardware default otherwise. dw_pcie_link_set_max_link_width() in
> pcie_dw_common does exactly that; call it before link training.
>
> Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>
> ---
>  drivers/pci/pcie_dw_spacemit.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/pci/pcie_dw_spacemit.c b/drivers/pci/pcie_dw_spacemi=
t.c
> index 3b5c2dc4e0..9b299ca17a 100644
> --- a/drivers/pci/pcie_dw_spacemit.c
> +++ b/drivers/pci/pcie_dw_spacemit.c
> @@ -41,6 +41,7 @@ struct pcie_dw_spacemit {
>         struct reset_ctl_bulk   rsts;
>         struct udevice          *vpcie3v3;      /* slot supply, if descri=
bed */
>         u32                     max_link_speed; /* 0: hardware default */
> +       u32                     num_lanes;      /* 0: hardware default */
>  };
>
>  static inline u32 spacemit_pcie_readl(struct pcie_dw_spacemit *pcie, u32=
 offset)
> @@ -93,6 +94,9 @@ static void pcie_dw_configure(struct pcie_dw_spacemit *=
pci)
>                 writew(lnkctl2, cap + PCI_EXP_LNKCTL2);
>         }
>
> +       /* Link width from "num-lanes"; without it, keep the hardware's *=
/
> +       dw_pcie_link_set_max_link_width(&pci->dw, pci->num_lanes);
> +
>         dw_pcie_dbi_write_enable(&pci->dw, false);
>  }
>
> @@ -406,6 +410,8 @@ static int pcie_dw_spacemit_of_to_plat(struct udevice=
 *dev)
>                 pcie->max_link_speed =3D 0;
>         }
>
> +       pcie->num_lanes =3D dev_read_u32_default(dev, "num-lanes", 0);
> +
>         /* Derive port ID from DBI base address */
>         pcie->port_id =3D (dbi_addr - SPACEMIT_PCIE_DBI_BASE) / SPACEMIT_=
PCIE_DBI_STRIDE;
>
> --
> 2.55.0
>
>
Reviewed-by: Eric Chung <eric.chung@riscstar.com>
