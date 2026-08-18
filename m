Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9073CC5DF7D
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 12:04:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ACE34608BF;
	Tue, 18 Aug 2026 12:04:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o5IxZiW01D0o; Tue, 18 Aug 2026 12:04:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 425816086B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787054661;
	bh=YGSnfe4F1IezbXG/idsX4RtXPHdpvgyd9W/Shb68FWI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=imeQefAi0VFAlELB8T8RgONgbJZLd8kgFdzjR6U00yTqD1MtlGy727F/yw1x3um11
	 9CDIB8qjST7nToIEIDkfVqFd+BFcxIDb1R58weja9IQDr9MXpHe5DxQiRN/fRHCgz9
	 dUiO2axDZOQlb6BvVEr25sk+s71T24uLxBt3hCB2f4W2tsF02d3QU82BaCQf6bRz+O
	 DgEg+Fq36Q0Q+i2ccbX/N8EcErYN5HdL12LkcDr54afZJVEt4OxUU4pVGI7Q5PwTnW
	 PZN+ZzRySEuZPJWusliUrnq0604PKR2kIUJ98LkxQK+HjiVy4Z7BU4Jke8nJtJQ5WZ
	 K4Go+s4LxQYRA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 425816086B;
	Tue, 18 Aug 2026 12:04:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0C6C923F
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 12:04:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E698F80B34
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 12:04:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FDzBuL9tptGr for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 12:04:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::136; helo=mail-lf1-x136.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 2A99A80ABB
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2A99A80ABB
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=FuymraoJ
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2A99A80ABB
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 12:04:19 +0000 (UTC)
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5b3119957f0so4076838e87.1
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 05:04:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787054657; cv=none;
 d=google.com; s=arc-20260327;
 b=PJ5oGeNSPLmRYljdGY4hrb/uPSRX1ZXaGD6Trk1/AZSHpLHKy3NYIqwJN4SEft9Inq
 fu6GpXSaYUkGcQ9x6+nS7GjAGb9VqPuy5D7SHTfz7vAw5xMVGgqi4dwq+6JrEBYHF3tx
 XQhoGyj5oujx8veWt4dzcrDnS4kFNK8zgASOagOfS47AfE7i4lxuXmMl5M0Txsc0p2rN
 WFFbpKB//cuso9KIzhDEJTNMc9yLQQgai9qo3OLBEXFWrg98PVGEHbGoaRr2gofznfUx
 NcsZNt9+jD/QLZnmAZqG8l2EaUuz0veXsPjFbzvuheKTGW5WqQvM7FWXEPVAr65RzL45
 yi9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=YGSnfe4F1IezbXG/idsX4RtXPHdpvgyd9W/Shb68FWI=;
 fh=4sv/oNU+N7epZXYrJ354OICvCAmLDxZf8w2D/NZnCdE=;
 b=hiMi4C48rKJVg+z5YL+5VlTpFMRTeU5TvGOeiLm0QiDprcs6eIIacigGVWBB0n1TP8
 dZIu95aT/+Op7x1Li8oX0PLVwyHq7O+eg3BlBDXFggxtn1l/A5ziSL+wbZdzRP3/t+LL
 YP23B1ac6J2jI+neTlYaN9sHc1SiRClrsN9Sl2gajozwOru6yFqXyvn4F3okdMLBqR6j
 gnX2oIgJo37IEZO998OGJWGwDCxwqHw7IrO8cQ4Oy7Eqa8H2q63m/GqcZ2OvT1F9x4+j
 yaIT0LTFldyzgUIQjrIW4AeWGJshBZq3NnH5WSvoq5BBZ3s76EhRMZ/vGfv/HTk02yep
 jEtA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787054657; x=1787659457;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YGSnfe4F1IezbXG/idsX4RtXPHdpvgyd9W/Shb68FWI=;
 b=FuymraoJG4/Q4GQIYtHIsHlXYtPesyOGQ8Mg6XFsm9cQj4G8+QUR3EEAOJ7hV+gGy+
 0jRttGsndOTg91amvHtqve1RleONtI7+5kduJvl/P2qflFAHXXGRMEPa41fnAM6iD5S2
 ocxrWfrBfyXcNBa5h6h0N9XA/wdbZCgByDDfSH7S3khOOU5z2v76WPxQ1uBLAifPqVxq
 Xs5ZGrp56HSij0CmEUPbWMBggklZhMMga8Lu1ep2mMfl+l0V13UtEceGvsgfhqeIqS21
 UbVfjBD7GXJZxUYcztbeQdua6Qa13i1tnofYeV4pWd5+pQjSYMqk8iXujWGLTXpTM86Y
 Nx5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787054657; x=1787659457;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YGSnfe4F1IezbXG/idsX4RtXPHdpvgyd9W/Shb68FWI=;
 b=XEmT2bbDpf5fuBwITO+heyOsdAYF+J24VCCrJ7Fv7BUPvcQ7D9f3mjFLCu722G72nb
 jsVq+rG8lS2kKVAi6fGrG4hE0+Xw+pB1UNSSJ1iKhfbQPavQgPhUw6IL0xLO29yl+nWE
 TOi4fkkcelfR+KQu61tVdBjQ7dNVct64C84l84RpTM5rDIMbE1gH6cDHcFbIvTzTjaH2
 tJ+cvMCt1gh8PqscVLB5Km6Xn1Vt3v88vhJutJPBwIsnV795ZG+4Z5DApb2gd7myx40W
 /7hvt5w21MKUxlfnvn4DlC1rUsTsp/PBkGjiEwy6cRngmo8K64+4Rap5tnv6Q2SUoYyM
 wXMQ==
X-Gm-Message-State: AOJu0YyG013RGBhcmFHjIknM1bN2QHW6QlisfTTcCMBcjt77LXOzJkt8
 kXXqwG4To2HICkiT21Hry/2SoA9+QdlXt11FhrkHruqRr4Eu/YD6zP6puTTumdBOCKwugzmlY2N
 a8Xe0DYHNy+H7juGKqPf6QQvR5U5c3lk=
X-Gm-Gg: AR+sD11c74w5V7moBhO7fFeUsYj8W8JcmVPA15x+/zyWjYMC4HHfZLmwocgCn9ypPlh
 KAL/ABln22mFCS9tVtpIdiupBN8N+c8ZhlSIG9kJNqlDTzsuSXWTzUW3jiiZfaMqjbctFWRQKOW
 qCBzQ4WCmvMouxtq1yqhpaIK/wkiaXSO8421iZBReXyZNWasKqlQDPT+si9Yzv4QJ82vYroGog1
 cjWtiVWIRqc21xj8li+PcO0jmbaKeH4ctYMokmllCQnOiiT++r70wF11TomZeT0x51Hq6bLW9S+
 GGxyqEdVj24hENVVtPLX+Mi5LbhC+GND7sCHHLPDRQDXfraSa+xOfkn3KpH9cCQrDTd2bozVi+3
 YMDVzIASV71fm5cjy9dz2srE8k0QW04R5B788ZTe7Pe5c
X-Received: by 2002:a05:6512:687:b0:5ae:bd5e:95f7 with SMTP id
 2adb3069b0e04-5b47066ced0mr1891077e87.4.1787054656485; Tue, 18 Aug 2026
 05:04:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260816232404.1223819-1-marex@nabladev.com>
 <CAOMZO5AOmyEbHS7tMdLaWuEoGgkOWSiVUG6Ln54ATPCUqWxCkQ@mail.gmail.com>
 <c5a9255d-b56d-4c05-bc75-f1a5688b9ad2@nabladev.com>
In-Reply-To: <c5a9255d-b56d-4c05-bc75-f1a5688b9ad2@nabladev.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 18 Aug 2026 09:04:04 -0300
X-Gm-Features: AcwNN1WsXBEkLzv1Dgv1IqiM7_J8i6-5XOlDiBbykC-8liQEFzXWpJZaGsa504w
Message-ID: <CAOMZO5A1gbzoFFc9PrvTpNBgz1WV8eb9aabhc7_EM2OqSjRvcA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx: Fix EEPROM address on Data Modul i.MX8M
 Plus eDM SBC
To: Marek Vasut <marex@nabladev.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>
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

On Sun, Aug 16, 2026 at 8:58=E2=80=AFPM Marek Vasut <marex@nabladev.com> wr=
ote:

> > Does this need to go to main, or can it go to next?
>
> main would be nice, since this is a (long overdue) fix.

Reviewed-by: Fabio Estevam <festevam@gmail.com>

Tom,  at the moment I don't have any outstanding patches queued for main.

Please apply this one directly, thanks.
