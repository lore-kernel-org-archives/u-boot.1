Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58BD8C5DF7D
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 19:33:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 03CFC80D56;
	Fri, 21 Aug 2026 19:33:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0FKWYErBHUO4; Fri, 21 Aug 2026 19:33:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787340818;
	bh=OnrykrbC97N3nPwSFPn9B8ApBTW1nccS9ZvfhsK9yBY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K7taa3z0BUQgVJAT1e7UiTYBIlG4zh44UdF705NVQCmZscx9t3cT6U+v93LqvvGzX
	 jwerSYN4HKnjnb90ov4SYom4P3v1tf35bj8j3jex1clJDllJ4c5LLTWhm1XSMe5YAk
	 VKn36wSJnHw1BBacJhieMNPAFprBMfFMOX1ncA8p1IDQ0iU6183qYUSRXjMxOyRDie
	 +sbH+yVfe0bK5XvWHACjBrSZPXCzmQUnalegJSN8l9arLaIdEv45Xj3hzns7DR5TTn
	 gm/AiBeKn+Q87iX5n/a3HoVXY7ZofC8AtYGf0aMdIo+f4x0jYW1vulPuXMfiezfvUF
	 hKf7jlQIan2DQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 27123809CA;
	Fri, 21 Aug 2026 19:33:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1C4284B8
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 19:33:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ED9CD409AC
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 19:33:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cNXV56cHPbyV for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 19:33:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::22a; helo=mail-lj1-x22a.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=iBKZ3Iu1
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B8833409AB
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 19:33:35 +0000 (UTC)
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-3a1981228f8so14184101fa.1
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 12:33:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787340813; cv=none;
 d=google.com; s=arc-20260327;
 b=AXu4XLxeT9n+UdUxIvfxVGvCK3yhGXKrMI7uTumDMylg4kOtf/XmywtoYjJ+Gjrua9
 51EHoWqFXv6S8A3Wd69Cl9yB8z6Ri/Rpqm872SkoOlw70V9QL8QL2buskeZjDEcNlCiA
 cGPlDwohhjEBFVWPfZF8+DSRMvk+OLvFbPBqUVlHV6y6pF/w8kcGYNW/iJtK4SnfeSxA
 cBW4PW1gtyAH0q14SK1rDbWjbP+p4q9VzTlShlnX46IOXeuj0sWUNmmRVYsiNRD18wJw
 szrOgiq0WnXow1cbWIunhhD36wJKXrbg0/K0TSi9n6+xIsbSP1YJNhtAaAwLdUBTvU+y
 lzoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=OnrykrbC97N3nPwSFPn9B8ApBTW1nccS9ZvfhsK9yBY=;
 fh=a18eQ1RVpL1aWxYl4TszqN0SID7gWhf6FQKUqgWycWs=;
 b=H1vuikTXd27A91SdEX7ksaRW1FJYMp/V3GktnJAlL8VnqE3YaVUceBj2+HKXVsZKRM
 cUKYNnOTL65Xn7v/Ru6siZCVjXCTCEmtsvM6ne1NWO1mUuJHQRraqydjz73lOmyPzBJE
 y09PL4XtV7gQMRlS0q0iElsgXEK3od1ducuajaSI6DzOAx7nZnM5Jr6s6flA1f2tjVtH
 qsGVyY1kKPnUrpT7agxTSv1AovBZJYlNVnlemZ2BolgD0ZAtz0Kqx/ZTp445044yW8fY
 fJL06Hq9n5Lp3YxBY5ol1kQQbr/UoQMA+AfSsUi9YyrHtgBJ2tbPGV7/CopK56hEhhZe
 /Mtg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787340813; x=1787945613;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OnrykrbC97N3nPwSFPn9B8ApBTW1nccS9ZvfhsK9yBY=;
 b=iBKZ3Iu17yBwUFyOqjiLDp852ozpnLUl3CHrOzALcEBl8u6CJpTE2nZS2DFws2+Eok
 9DTFKqd5t37e0mfPBd045Eh77YLjYsxUMfDRfO6kOCXP9NrIvr6ilK6/DYaI7UmGCrdG
 k7cWJl570TIv25HnBwva3RAB3wO9bf1mB6ZPOxBgPqBtv5TfJ156in/y76jFDIOZrXrI
 UpqedyJMVAnCWa8ynSc5F4sEtBYgVFmeZ11v9993izVv4G/b30GMX0/04HuBX8rDNZgs
 +O66RuA0EuUePSdCBAZNpdMqL7lLG7F0TBAwkiAR/hWoA9gHcbWT5h6uwj/4hZWwMqiQ
 y3IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340813; x=1787945613;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OnrykrbC97N3nPwSFPn9B8ApBTW1nccS9ZvfhsK9yBY=;
 b=TrNAqgRUsS1RPZ9YAZuOU/S8nsgVBO+p9XgC5zk7XoNzF0KvBzcblicfYMe+FT9hIA
 4zYMiI5toQR7U0UFoSZecj5MGbp1pBv1fwlDrhmrLq7T3+hc9naC3f8PHfJYgUy8mXz8
 U/Y01QLCnOjxWlRy7XK2nlHhAgMa3sAmNvyZuGQSgp4T+Hk6F+W9BD8c9Go2mgYHbwvC
 B33LcWZrn9cpyrGVB8b698pJajHu0kR2GVbU5VpUy0yuoM4P/x+9AQAAFZbbb0gSSXy6
 9vMPx5lNEF/RpW70oSkN1U/OljHtSPXvsTYeu0R6tm7BE7Kcq2D5Edd+nKkm4EfzW7rj
 RUXQ==
X-Gm-Message-State: AFuF++my46Jb+1vSv5xxkHwR9hDzxIX6gK4q3OFwjhZANzUBHdGLY5Qa
 JCv7Z7yG4KW1vgjXDx0pQriQ0Wnhr+ITwkNErcnZ7i56EFjjBYtVmsUzIvY89nc3t9I61szRmqF
 ebyxC7jKMQ0bQhLWuxvYR+Y247LWWcVo=
X-Gm-Gg: AR+sD10rXATejyznf9IpxC9Xu4i9c3BDmBvchcHET9IO0pcFOWZvApZ4FnfJ5dzlnRG
 +l6prkjLMPu0ILcaL4pmmc4jNQGpMJf/QJKR3Iq1MbNJ87MmpvnyIrbt9Hl/g3+GwhVcg2fwtFg
 6UPcp1LoqBjC6pCfnwd0dI979cr5pTEjbU/D9pBq1FG3QjtPFx3WpwOfv9ktiiZph+s8xxTigp/
 EsqSV5dBaFOmL7do+PmtfIQFr9jP6hCpliji1CIaKkCiyuf+cJwkO1L40cYm9fK983gqnG72Ggy
 v7kVEOyCmtwRMJizcXlEpA1TBRWzSWnUb3lgfqf5IUJsgIfgGPbemKd43XWat6kc8GR0tnlj36S
 wl5qLLykMZGM/P7XgcfsIfAvfsmPt1R14eg==
X-Received: by 2002:a05:651c:198a:b0:39c:7922:b446 with SMTP id
 38308e7fff4ca-3a1c1ee1c25mr2304121fa.14.1787340812658; Fri, 21 Aug 2026
 12:33:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260819153014.834228-1-petko.manolov@konsulko.com>
 <20260819153014.834228-2-petko.manolov@konsulko.com>
 <CAOMZO5B-Q6R652_wp=AWXURBSP8Npr_AwJUvaw=CYSL7=bJKKg@mail.gmail.com>
 <20260820061912.GD24421@carbon.k.g>
In-Reply-To: <20260820061912.GD24421@carbon.k.g>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 21 Aug 2026 16:33:20 -0300
X-Gm-Features: AcwNN1WUZcmCHXXhGJL5e6hiBc9Y2DsD4kO9tKp9Y5MIvEEC_tobiNq2Q38EX18
Message-ID: <CAOMZO5AfFXrpN3RMPuYw4vM=AHOWBj6hnaXdG8W=KhSsWj5big@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v1_1=2F1=5D_arm=3A_draeger=3A_Dr=C3=A4ger_M48_on_NXP_?=
 =?UTF-8?Q?i=2EMX6=28Q=29_and_Intel=2FAltera_SoCFPGA_Cyclone_V_devicetree=2E?=
To: Petko Manolov <petko.manolov@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com, uboot-imx@nxp.com
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

Hi Petko,

On Thu, Aug 20, 2026 at 3:19=E2=80=AFAM Petko Manolov
<petko.manolov@konsulko.com> wrote:

> Unfortunately this board runs QNX, not Linux, so upstreaming them doesn't=
 make
> sense.

I don't think the OS running on the board changes this requirement.

Devicetree describes the hardware, not Linux, and DTs from the Linux
tree are also consumed by other projects, including U-Boot. In U-Boot,
we have been moving towards using the upstream Linux devicetree
sources rather than maintaining independent copies of board DTs.

There is also an important review aspect here. The Linux devicetree
maintainers and the subsystem/SoC
maintainers review the hardware description and its bindings,
including dt-schema validation. Simply running the
validation tools locally is useful, but it is not a replacement for that re=
view.

For the i.MX6 part in particular, this is a well-supported platform
upstream, so I don't see a reason why the
M48 hardware description could not be submitted to the Linux
devicetree tree even if the product itself boots QNX.

My suggestion is still to split this work and submit the i. MX6 and
SoCFPGA DTs to the respective Linux maintainers first.MX6 and
SoCFPGA DTs to the respective Linux maintainers first. Once they have
been accepted upstream, U-Boot can consume those
DTs from the upstream Linux tree and keep only the U-Boot-specific
additions in the *-u-boot.dtsi files.

> Can i use some sort of DT validation tool that pass kernel's requirements=
?

Yes, the kernel provides dt_binding_check and dtbs_check targets for
validating DT bindings and DTs against dt-schema.
You should run these before submission, but passing them alone does
not replace upstream DT review.
