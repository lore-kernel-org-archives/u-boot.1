Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E55E3C982D6
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 16:04:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A97296085C;
	Thu, 17 Sep 2026 16:04:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hE2VtPce4LeO; Thu, 17 Sep 2026 16:04:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D6C51608A8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789661091;
	b=LOkczxtREvfMdsXbu3ZqrA3VJ2Ijth4z4ba0mngXCNsdma7BNuLQr0j5cJFD4I7xOrs1
	 r53b/BU43RP6d+RD5DMUA2EYOgYGVXgN3weSncEQtPiIRj+bkIZFB/3WBKlon3/UpI1/R
	 j+8x0n2QFvpDT+zKwxBpTrhZue9Sh6uqllyuwk9+2R7ZDQex+SD4V9UOnCSuGUvt2L5aM
	 Jm5Wosxy0+izJv7sp/KADD10Q/vfAme9z9FtWIitcRH5JBl/hkoww0UhyqZNH0UfWDESd
	 H7/LgghtRjqqXAUwDLQpWZnbKCHqKHUn6z18wugWBrhu0XuqaUfGkRB/YflJWPH1fxQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789661091;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=bH9gfSAyahBh43JxdicJuVLH5ZGlTXElVBwIxVxKYgU=;
	b=IcSv2J2NzYS2JFEA+1FAW7QD3+fq7rbi3HufkDVCQlMmSTJk6ezu2aAPosnwX3Nce/pQ
	 /kS956VPH9P1Njcl6Qum8zoMlWdlOr8DBi96K8bP+S8twTTPssZ/r8hucgKYAjGXqri7C
	 hKUZTVpMzdDWVcsCjusRG7CjaNQne3BmhzVw6W+fzeqmQnL9TKE7IPZ4oLW8c8bThiTWN
	 5d1LtAHZV8nKlPJ+GDZzfkJTDTipTCxA9misOKMcObD9YRorM6lgOG14Qv9X+N0+wK3sn
	 Na/u8NduBpkDO3R6MH0rZQEyyKNu38t80PcI4NqVfVWinW/IcSRW8u7Rwmt+3M99bJA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=yxTl9hHS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789661091;
	bh=bH9gfSAyahBh43JxdicJuVLH5ZGlTXElVBwIxVxKYgU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EGn3lE5ZLMzoomTT8pjrc6301LcmTq7nJ1rRrJNuja3wkowohgcfLM4Io7OXHlTC6
	 6zB0TBntnpiSP/T+gRXuVzry+7LQMoc0kU6U4DpJEsjqqw6dARjHvptoDs56g+GiqX
	 Qa3tD/LC/gEKZmdMIo8ChxfARZjyRzSz/TvFUBlwUs13Hc0szsWmVwgnUbqVp6Fk6N
	 iIEjABW6h0UdTysT7xDb7yhoPIF1CYGecjJJFttAAUx8uaSnlPUYPclJKXGF0n7aed
	 ArxyQ4l/vlSBAIGQQrzTDf0MGzyD98FMfuDcegcJ2sveqizBozi8DTb0N/K0EkW3I/
	 PMCkJsWKFJyhA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D6C51608A8;
	Thu, 17 Sep 2026 16:04:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A32BE422
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 16:04:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 94C98608A8
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 16:04:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OC4eu05vteZ6 for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 16:04:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7ABF36085C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:41::1f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789661088;
 b=A8xwR6jBrZdp5XuQEOikzJeGLMP+49qTOtnI2P3zy9Mfzfs8JhaTKltfsMjryeh2odmY
 mOhTa8jHZKizzkitonMSDReFANBbpJe9K5WXFRsgavMrW6lkUBCiEF5lgWzJwi9RNakKw
 Imir6RBRfatR5hFsFFL1IYdcq2n7WZa0fbt5SKgPxa1Wsjm+XKSzTgEoyllwM6DHcdJMB
 FAaxFvJSRE9dvObqGuF2x5LlYfMZ5cJ1HAksO88o4K8ogiD8zsK548RF+g+T3NKA1Sxpf
 bQmNAlR0RPhteRmmh5H2q5nPc79RXPx3XmEzk3cFnk11K7Rqcr36NhLjPqHwI55gvTA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789661088;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=bH9gfSAyahBh43JxdicJuVLH5ZGlTXElVBwIxVxKYgU=;
 b=TSFvroGiyt8RbpanzfIHn462x2tjIVULrSo80nv13wrI7aBkrptkXggBwrbytOLCT+xK
 iWVwgyYkkPTOYHVuVGSCfx893vAkzmAoQ0Bu2MXi85cVZwUbpDeh4AkYkmWSSwcSBbMSV
 Fx09DW858/haESoGYyZKyJn/IlRALUJcR0BonNEaiP51n18LFyvRmMpsc5SFzC5oJN5pw
 qTmteszWz1Ll5JakINcZgjtaY62zLfmxEkkNYD+N6BZfnRQASuBpUrMJjE9lIjldXNT1w
 3FQGoOBNDNP6peYC5pKqIO+zD/uCDNtBhOfLAl9T5fjV/EbhG0F8desIJ6PSb/0/PRA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=yxTl9hHS; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:41::1f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:41::1f; helo=mail-yx2-x1f.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=yxTl9hHS
Received: from mail-yx2-x1f.google.com (mail-yx2-x1f.google.com
 [IPv6:2607:f8b0:4864:41::1f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7ABF36085C
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 16:04:48 +0000 (UTC)
Received: by mail-yx2-x1f.google.com with SMTP id
 00721157ae682-895fd505832so4469477b3.3
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 09:04:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789661087; cv=none;
 d=google.com; s=arc-20260327;
 b=UuLf3kGXXaC1L+72UH90JAeY9cUK+MOuthqqUPCXr6Z9KUiaK8TkKV74i6GNbeycg1
 Vbacz22R4AnT6++7QT6W3IE6q04+7R+bqMs2EBABPzEd3Hts6HBwNXV25TZgKEFR+Rib
 u8l89+esEWdmc/tyhZDzNOAZgTXnTnakTX8Aq3vgRu3/YVESnnugrIcO5bVrwN4ubXus
 7JrYXlNBCpWeHUblbprRJcvLRS+JWwBSmcYhIfFUGdv/r72+0HrdeBY43VV6Xi+RIaZY
 LZPpgxIAJ2oSXMTk8hc8t4aSy4dJZCZlBoD5tW32jdaD9FXYfYq0qXfNOnn3dux6HUJu
 0NPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bH9gfSAyahBh43JxdicJuVLH5ZGlTXElVBwIxVxKYgU=;
 fh=nuBf3wKo1f6h1jUIZsacuBBNlSv8DnOg+7qF0rK2IQQ=;
 b=dS7sr90qH9iv+qFovPDXny2WygYus9QooTBjWhNh63YmPYmbo4eNbOavlVAggmMh30
 s0ztkndKOQSNDFPeRDC1NsWdORE9adLw0VFe2r6atOViNF1CNnNwJMU3clvhxPsE0Hv5
 8/4WIGQwzFuuKAggJUDeewCIMs6Rb5HHlaTVDlnuid6PLo82Od42zdGeY0d8QXuiMJ0U
 EmlNKbIJmNjPuVB7JumVTQJoW4uRYZzkUdqgiZhb0qwCxUoQxH3DsEmxXSdGP6DswNHz
 KH6bmME/pzDO/7lU+K2bdnUpC7luDUcewGtD4L203OzSI76oc8Rl19WG9ORgxZ29UKbt
 StEg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789661087; x=1790265887;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bH9gfSAyahBh43JxdicJuVLH5ZGlTXElVBwIxVxKYgU=;
 b=yxTl9hHSxMV6a7znX3bbJUkNYLrfK7Q2g/u4FsTsxGN3GzqanQqoI7AWCJ+YTlcxHd
 qeP00z4NzKuhtylrIMgtudeHlMkPEVZSl0OPuuyYBvCGFJz5KXSqKlFATkMQbPR8LJQe
 2mWHBvfcItFs7ts4CuAxKNQi6fqMY6YbjU5fJTzDtPEDGzlYwnyVPgwDiQhCteWm3wa7
 vqey43F7tGM6KkVY89p4ax5ZN60i3JoqeI/x0aGHjqqY2N5zCqnesV8Y+5TvdXrv/jSK
 vUvMI9dAcUJbypPOR0lQLeuXwgiWEY3YjTneKqEYRzqlZNKtkmS33KdoPjKKUKfNyE17
 8aNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789661087; x=1790265887;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bH9gfSAyahBh43JxdicJuVLH5ZGlTXElVBwIxVxKYgU=;
 b=Pmoo38u6MbtqPc/YksfIeGIlya/O7LIQWToRJ5a655NvbpsMHT0nn90kyvlwh3HNos
 H1VEEc9pBX3lcIYg5z3i5AX3XigcZjm1CXGvAdoJV7yZpaFp6cLeVRCVhte7c8o3tmzv
 B06Wrz+meUZNoWB3193FWv+Ae8dUPSBXF0fw0Kf7B9oPHw6Y6D0XB+EweFHbOMP+yLtq
 tUtmaHnlhNh35qb3TSgfpowHY0Ee5x9SNUmNp0fYF/5SVoRoSbzd9fW1BInUmg30vGf7
 R2oC+GjSgMkhdr9i1/jIo2K2lSR9Jtn+Ui5R7cGuBl0joYZlf5J7PaCsygiOeuQ3et8f
 c+yA==
X-Gm-Message-State: AFuF++lE66go3SH7se2EnzNY2YNd4cl1nckirTtXbx392DO2r8lg1WHa
 NGNXSYR6BKRQmaPDCN+mhzFQOK9UxF3xkyNhL9o14hHmJbSrWB/CcrnNzreKQdH0Y6KpxXqFXyf
 bD5jQ/AFnj69LdTP7UceNgWF0wL2coS5qVfXUYZLAig==
X-Gm-Gg: AYBFou05W47ZG3qGQzyKal5lO3IQMG/8eEie/tOJUa0ri8ja/6Flt45oYLsUV5x8FLc
 Xb52a0a3d8jIXSe0fNhoGJh6e47eRZivnn2IQ29QpgG2FNx/GvIU6kcIW6rHUUXUM+EJshdih8T
 xeFpvw/bVD04mqDa5gGtdGEa4XKLDgtDdSK8MI0lHM3dn8m8F6yPRnue4+wkxuDizIiLj0K08v1
 6BcOek+lPDCerRscFe/v8ngdccQz1GYIf5HukWGbUeTbP2EM4KBDqJsmKF7gVBfggLaq/qA7w6j
 blIUUi5qdv5N8n5rrYn9Z79M7xBxnHRcJxfb++3eq5ijimCJHnBAG/3mQHb7/MQraEFANrTy5Qa
 K4ZAEJL0WaVDGzqNZwOo28WmAet64V88cZOVVE5oFL/DXNfmJN4PtarsRo+9pazOHuQxmQx71YO
 mC26QLMKWjy0uje0fUS6Bwguk+UbeDptV8UYd+bqXii7bTV1CHrQwy+4ytNZFfq6TAVRnIfaAxm
 qRBh6OpKgMMRlCA65ZmLAI7oy6dGBKlTxPHN6iFHNBjKWaEAWPbm70BVykfsZEo+GX4o2+eHQ+0
 Kbr9OGPPxnuQBJHJzvoCquN51ucusP9z+utqhm4nBOJzn5UpSnakSXZSKME4S0t1sqQKHY9ELQA
 RKx1NZwx6zFh08dxyBt5xcy+sQ6h8PhyujG9cROt6Xslf7dpW29JFxNe5/xX/mgzMnw==
X-Received: by 2002:a05:690e:d02:b0:66f:c1be:a65c with SMTP id
 956f58d0204a3-671632d6f85mr2028157d50.78.1789661086923; Thu, 17 Sep 2026
 09:04:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260904-conform-v1-0-475b2947631a@arm.com>
 <20260904-conform-v1-1-475b2947631a@arm.com>
In-Reply-To: <20260904-conform-v1-1-475b2947631a@arm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 17 Sep 2026 18:04:07 +0200
X-Gm-Features: AcwNN1Xewz2m26jPHLnUoUzkIx6O8ugQ2DoBQDp9_LXYymHsG0TbAbH47fMjhcU
Message-ID: <CAC_iWj+y1YnNfhijUdtzJhXJ9ig23dLnV9yBgZcT9sB5Kipk2Q@mail.gmail.com>
Subject: Re: [PATCH 1/5] efi_loader: adjust EBBR 2.1 ECPT entry
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc: u-boot@lists.u-boot-project.org, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Shantur Rathore <i@shantur.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
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

Hi Vincent,

On Fri, 4 Sept 2026 at 17:01, Vincent Stehl=C3=A9 <vincent.stehle@arm.com> =
wrote:
>
> Adjust the EBBR 2.1 conformance profile ECPT entry configuration, and
> prepare to add more:
> - Introduce the HAVE_EFI_EBBR_2_1 non-visible configuration symbol to
>   compute the actual system conformance status with the dependencies.
>   This will make it easier to add more versions with a chain of
>   dependencies, while avoiding a chain of nested submenus.
> - Adjust version 2.1 dependencies to better match the specification.
>   Relax the dependency on the boot manager, which was introduced in
>   version 2.3, and make the list of required UEFI protocols and services
>   more complete.
> - Reword the EFI_EBBR_2_1_CONFORMANCE configuration entry title and help
>   text, mostly to separate "EBBR" from "v2.1" and to attenuate the
>   redundant "table" mention.
>
> We do the following additional configurations dependencies
> approximations:
>
>       Configuration symbol  Used to approximate
>   ------------------------  ------------------------------------
>   EFI_HAVE_CAPSULE_SUPPORT  Firmware update is performed in-band
>                     DM_RTC  An RTC is present
>
> While at it, refine the ECPT help text to attenuate the redundant
> "table" mention there as well.
>
> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> ---
>  lib/efi_loader/Kconfig | 36 +++++++++++++++++++++++++++---------
>  1 file changed, 27 insertions(+), 9 deletions(-)
>
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index 4cb13ae7c8a..40380876959 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -557,23 +557,41 @@ config EFI_ESRT
>         help
>           Enabling this option creates the ESRT UEFI system table.
>
> +config HAVE_EFI_EBBR_2_1
> +       bool
> +       depends on EFI_LOADER_HII
> +       depends on EFI_RISCV_BOOT_PROTOCOL || !RISCV
> +       depends on EFI_RNG_PROTOCOL || !DM_RNG
> +       depends on EFI_UNICODE_COLLATION_PROTOCOL2
> +       depends on BOOTMETH_EFILOADER

Similar comments here. The BOOTMETH_* shouldn't be a requirement

Cheers
/Ilias
> +       depends on !EFI_VARIABLE_NO_STORE
> +       depends on BOOTM_EFI
> +       depends on EFI_BINARY_EXEC
> +       depends on EFI_DEVICE_PATH_TO_TEXT
> +       depends on EFI_DEVICE_PATH_UTIL
> +       depends on EFI_GET_TIME || !DM_RTC
> +       depends on EFI_PARTITION
> +       depends on EFI_SET_TIME || !DM_RTC
> +       depends on EFI_UNICODE_CAPITALIZATION
> +       depends on EFI_ESRT || !EFI_HAVE_CAPSULE_SUPPORT
> +       depends on EFI_RUNTIME_UPDATE_CAPSULE || !EFI_HAVE_CAPSULE_SUPPOR=
T
> +       depends on EFI_CAPSULE_FIRMWARE || !EFI_HAVE_CAPSULE_SUPPORT
> +       default y
> +
>  config EFI_ECPT
>         bool "Enable the UEFI ECPT generation"
>         default y
>         help
> -         Enabling this option created the ECPT UEFI table.
> +         Enabling this option creates the EFI Conformance Profiles Table
> +         (ECPT).
>
>  config EFI_EBBR_2_1_CONFORMANCE
> -       bool "Add the EBBRv2.1 conformance entry to the ECPT table"
> -       depends on BOOTMETH_EFI_BOOTMGR
> -       depends on EFI_ECPT
> -       depends on EFI_LOADER_HII
> -       depends on EFI_RISCV_BOOT_PROTOCOL || !RISCV
> -       depends on EFI_RNG_PROTOCOL || !DM_RNG
> -       depends on EFI_UNICODE_COLLATION_PROTOCOL2
> +       bool "Add the EBBR v2.1 conformance entry to the ECPT"
> +       depends on EFI_ECPT && HAVE_EFI_EBBR_2_1
>         default y
>         help
> -         Enabling this option adds the EBBRv2.1 conformance entry to the=
 ECPT UEFI table.
> +         Enabling this option adds the Embedded Base Boot Requirements (=
EBBR)
> +         v2.1 conformance entry to the ECPT.
>
>  config EFI_CONSOLE_DISABLE_ANSI
>         bool "Disable ANSI escape sequence queries for console size"
>
> --
> 2.53.0
>
