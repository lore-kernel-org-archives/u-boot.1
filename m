Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE8CCA5FC1
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 05:39:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 33EA780F19;
	Sat,  3 Oct 2026 05:39:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pXma1ugPPWfr; Sat,  3 Oct 2026 05:39:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6D52D80EF4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791005993;
	b=NTubMTXXbaHb6knoyl3o78dfiFVCphcYA6FRYXOKZtovJKA2dSzC3U0T6MK8pbpIHCzL
	 U56xW9zbS2FFepCFXjHqBemLp+Y1maRuwMF/FkQRV555kxwgDGyN/drtE0DcBDuVXeQPS
	 6iwUE3oVAEallx7J5BaVw8zcSixr65agFILFFZy13xrOBAx5g8AifIxsFssBCN4dNvIve
	 jQMvtC2ka+O1dFXkFnZVtWLYGKkCxb3Yvht4hW6awUrH3sSGebVSupFpwNeqkZ7xtENVh
	 B615FNE/yHU5JDvH/F+2SwVTCzluWwrmiT1At3uoxwgTiKn4ovRVaH712c2JVZNOBOw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791005993;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Lkz32oWr6K+tx61IsHbt9LMQRrBLaqPYZ/Q6nOJih+A=;
	b=Moa3rmDHaepcAQD93I2ejm9N6aVWciBtsfluvk8Wjr9NwD/k+CYU2VsT7F+mZnJbo8/v
	 hm+ECVtEtTlcVFjUkuGIBmXTBBr0GT1B2JiMUg+vRGuZ6KIPxUV8eQvamK2f7ihFVRuMw
	 dAXYrefs+irxDGtfyQ/Syu2hneX0ChuwLaHpZR5wDdTBFWt2ZthqU4nRPJhZaZCDVZe5v
	 IKteNvYZpCTVxej5VUpyfOIckLKn+dTk0jp7ryxVe0YZksAcIlgC8gYS2x4Q9ur7ssEnJ
	 ECIEYYaG3XAeEJj90xmkitTZNlrF7rqwuv/nuHq/f5JpWsQcDHs0449cm9UpCFLfj9Q==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791005993;
	bh=Lkz32oWr6K+tx61IsHbt9LMQRrBLaqPYZ/Q6nOJih+A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qa2ZNYWwP9HJ2ZopIKFtBwMNMy0JnSAKWPu27jDxAJACh80bs/XSt6EIY8AaOmDrz
	 RBNtvczzXgHS+PB69kaZhzTnzVEcXzlTzqPUeujN/phEUybE7V9K/sY6RMJvjC5TNm
	 A3gnD0rlAPNM+HMs9B7jm1afWcKlkiUfTBQgiHas/WI+3sdKSfBYzojDJskBXuW9H2
	 GbXoLxCYSokQ5VjjUrCR6Y8J5B9VORiES1iwEjiBp7ks/vggBoB2XlarCe6WrGsfI6
	 tYQsMRZ1jAFoI56F0iXsCdv+vCnQ8A1b14hiItOVP6qRHL0hLS/WLXHqAV+pjPTfZl
	 CJe9jonD6IGtg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6D52D80EF4;
	Sat,  3 Oct 2026 05:39:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C9573179
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 05:39:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BADDF40059
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 05:39:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AxtwJ4yMgOBH for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 05:39:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org CF7B940050
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791005991;
 b=Upo3MVPhGjtoE+CRweurhyYLP9awdE4PvJtavwf4NyZnMY5l+ZSPu//X2rTu7NnUSu1R
 ORoPpyTQo8FNzlUF55Ihn7VbLWlJ+I5N1/zzhX9eP301k7NZdFeQzbv/l52VlDqJ6n/eN
 SrJ3l0jf7p4UdFvhXw468hEPcZrd6oLARqydbqg6EJsmFe3qhiqwY/H/rMb2iKIHwBtrF
 ybl3TMsSXjN7orpDPzx+O8IbcUvdfimorl3Jj2lYbb4nVZnCwssQE1g2JI1WXTsTaTiUx
 vp5lUYxY9SaRqtjRxsra4AlpQL1uzZriLE0tO89aomHj1m/9/fC7nPFULdq8Cm2YrcQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791005991;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=Lkz32oWr6K+tx61IsHbt9LMQRrBLaqPYZ/Q6nOJih+A=;
 b=j15ciAKkf7dR7OqrR5WMCKUf86JfUTB302Fe76GTSlTHMrKFY5nF16rNva8OR7mpBOTW
 OdpGFP557ROzyys8YEUGXc6krx9z11NZPKEFnI91woqNr25Sr5Ob4hPjvlRh7th7zSR7a
 CqG5g6XpvSq39ypkOhTDnIw/1oLzm61jziKatKmD5Agax6rQPm4GxIRvei+Xm154NMl+z
 seWyO3XTBZMqkW9F30zXZb6HUD7FTnZNDw2pdNZl+TfBipT5uhpEH+8mC85jDoRvOZA+p
 LA/Ib4DZnnkDVxzE7w7hQUSZF+xldSp2gEyHk2F2TlHyMkN64gJMx4veJzI9BP+M+YA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Osghj6ZN; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::c"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::c;
 helo=mail-ed2-x0c.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Osghj6ZN
Received: from mail-ed2-x0c.google.com (mail-ed2-x0c.google.com
 [IPv6:2a00:1450:4864:33::c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CF7B940050
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 05:39:49 +0000 (UTC)
Received: by mail-ed2-x0c.google.com with SMTP id
 4fb4d7f45d1cf-6acae8342d2so189489a12.3
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 22:39:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791005987; cv=none;
 d=google.com; s=arc-20260327;
 b=o8oacK/yDfAI4dcLBySech0eDJF5A0q3/Ds28JX4azvjNDbeEhjuN8Txib+j/+1k4U
 Km2Y9NSyyUfCcSUaE+59vJC7gxXj9tUA+zFe1vCojO46o9Bf6YyKPCWsQnvdBlMTmfnD
 HbvAKW3mglr+rGSPIUJJOA1H/5RGBJVyxJ6HmuAssnnecj3sOdmrI7/j+EdBewgZGLol
 pAXFY8vljt0HBtR12zmTnSXnXwrdWezPAmJXzoPeyDaraq0SqJZuK8Ta8uxllge8+xoO
 UK54tR4tHRF2AenknH0CiItt6U/TJtJt/WHIzXcOvI/2zHZLOwFmYlunMo9Dqt8gWwBZ
 mUMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Lkz32oWr6K+tx61IsHbt9LMQRrBLaqPYZ/Q6nOJih+A=;
 fh=/iSLKRqVvo6KJdHoN8Uo8Tff/SD7I9J3YwaJdCKLPiE=;
 b=Kv9nYtR+8+Pmt9V5tkfH8zIJ6Fpkbp1wqD64JoBDJphwPSUjsvDgJMVGvRybbKQ89a
 MtMfvV2Np9pgOWAyNR7pPqpQXHIlQs+GAb26axvEOOCfg6DfkQA63Q3W2r+tA8NIEXl1
 c+4ajOBu19Arjl0xlfZeO1hpyp1Hl8s00o0THUm/JtO9O5BW1NeDuv3NLS97ApbW5oJY
 3vrf80krrzIWrO4U3x1SkSp8biR/3GofzZVczVu/iaIu6luBFzHOjrJBWwdWunQx3r3G
 bq/WScqGSR883HDvFy/lfWlAmSkjomJNgxWfBx32aQ4+ADED+kgi2ekNZwm9+AULY3OE
 3LwQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791005987; x=1791610787;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Lkz32oWr6K+tx61IsHbt9LMQRrBLaqPYZ/Q6nOJih+A=;
 b=Osghj6ZNYwkYAvE6QfutvKb8GUgGGLrPY45oJwuQ7+1tn4UulbE8+APU85Ga8KUL4O
 QzheXbcKfD8lxYzwibsY8VHELLKT31X+yRDkOHQs+0XNCkanJRwn1VHte4isgXzzHZyv
 MId/mIDBkazb1OPJhfhaBYbCDj83CHMGuefJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791005987; x=1791610787;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Lkz32oWr6K+tx61IsHbt9LMQRrBLaqPYZ/Q6nOJih+A=;
 b=wIOpzE7Y+OFO+d0zp7ACKwN/Oz/YBaqYiONb47KoDCj4RS2PIQ1slTo0QUnOmWWqnR
 J1UJJAILSDeYM1IDXXyFII3gUwfFp2QMaxiKT5+c5AS4IQjyMI5+m7tkWz57SZI5XrKG
 XX/bK4HHehfhQjnpVkPSuZzH5/oTuEDAOZKRzpsWSpnyjkBgIAOCgaQxcRFGjW6rpDSD
 XbGBpRgdR2mcpKLvEB51wlfM30hx0EsuVrla6Nza+cJKaYi3XN73yhbFQBv12xKT9Fw7
 Buin0pxMJtuU/Y6qPzwczDa3M/gQY77t8cOiF1y7EzZqepO1wiPeJI4/BeGvW7LZTk+1
 oTyg==
X-Gm-Message-State: AFq9FYKAZMgj1Ug6gf0rHSCQrS06nst2iCsOPcK9k/PbzSk/hOcgqGii
 q30rcohBOzRTsarq1oThR1SkwvEQSH7QIDnCTfajn1mGF1LXmm5TrKdkvFhn3e+hgnR5XyS/ap+
 PDfrXRmU7ceodOWt0sBe0Pp0V7CL2RaX88XyQRvVB
X-Gm-Gg: AYBFou3bpQBSnEpoOS1m/2EUn9bgU1FyZKk3YEsDKwYmu9Fq2Gkiq40lEo2t1qjVBXT
 rvSuSle9um4mLDnKBvduKRzU6RZHsNTlDov9W5zQtv3DZNXM9FeSXlrVPTdUqA6QIsd+MEf0JzF
 rKCx0rdwbUcIVg/SvbRhqC9miMfmlnJXq7FRUJIvjuR8Ij6rzBuq0Z25VawYiBu6myoivAYRd3j
 1C8xTVMOS8gMJ5wkAqZK5reFryYvZDUpdllrImv0WHBkdqyuhEISRXTfPuJjch9ZPrgnituTkct
 Eve21h9ZTsy6GcrhXSf7DiTX9JjHT5p2j4P9vs0ISSL5zPJC62d7JNUu
X-Received: by 2002:a05:6402:254b:b0:6aa:fac1:3bff with SMTP id
 4fb4d7f45d1cf-6af9e357989mr3763952a12.32.1791005987382; Fri, 02 Oct 2026
 22:39:47 -0700 (PDT)
MIME-Version: 1.0
References: <20261002-authi-v2-0-900f6f9141d5@arm.com>
 <20261002-authi-v2-1-900f6f9141d5@arm.com>
In-Reply-To: <20261002-authi-v2-1-900f6f9141d5@arm.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 3 Oct 2026 06:39:34 +0100
X-Gm-Features: AclHuK-VGXN6h0I3c5ZSNC5fXbCiSjoqNBo5pVFvb6R76qTECQgnQQuGO509EkA
Message-ID: <CAFLszTgB3Fv=Puvv=cRemA14bzB3gFZuw-s0JM6nx8_V6RPM_Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] efi_loader: fix image info authentication attribute
To: vincent.stehle@arm.com
Cc: u-boot@lists.u-boot-project.org, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, Udit Kumar <u-kumar1@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass <sjg@chromium.org>
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

On 2026-10-02T08:37:46, Vincent Stehl=C3=A9 <vincent.stehle@arm.com> wrote:
> efi_loader: fix image info authentication attribute
>
> The GetImageInfo() function of the UEFI Firmware Management Protocol
> returns the authentication required attribute correctly in
> AttributesSetting only for the first image; fix this.
>
> Fixes: 88a2ef2720f5 ("efi_loader: Enable uefi capsule authentication")
> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Sughosh Ganu <sughosh.ganu@arm.com>
>
> lib/efi_loader/efi_firmware.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
