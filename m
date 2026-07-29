Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57254C54F51
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 13:41:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1F2718129C;
	Wed, 29 Jul 2026 13:41:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o1DxxALuuVeG; Wed, 29 Jul 2026 13:41:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 82C9D811AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785332493;
	bh=DEL060wEvgC8U6URH92DURnzlVUPhuCzPO1W+gPMu8U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LEdCfCHDa55cMAFJnFVmUFVfX0AnU3HQkU/0YTAv1CQCHfitGyDtKFGTyMRq7Oaku
	 Bb+4fTmxgcBV7Vmzr0qPk4jYBNvUFUpMmJBzbzDL7TDgpXE+YyJcQA+2yK+4kg3A5O
	 C6PU0hTOWHR0N73LCAx4OhfDUqnZ27+D2lOoVI7eu2PckanjBXGHdCjkR1b+8a6VZb
	 mmzM/F5egMKVy4RtSC3g7UyxmmJBxcjRM/FVSi5kitDoRe3mPsIS5pwipRBK8BqJbe
	 8I45JZv3K5aKPIVzTdzjPJxdYXPkXQ8uctIAQjBhD3kutj+/KKjSQINPOeZAOsSe/b
	 aiCZhL7RGZAig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 82C9D811AE;
	Wed, 29 Jul 2026 13:41:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 67E42194
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 13:41:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 65326408EE
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 13:41:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JFof43OviBkl for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 13:41:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 861D3407E5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 861D3407E5
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 861D3407E5
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 13:41:30 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6a051b737d8so879775a12.1
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 06:41:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785332488; cv=none;
 d=google.com; s=arc-20260327;
 b=fKKXW62nTD37mF2vINiJB4yo9PUIgkVHvptoEYwe52RXVr3PQXYBr4yep5ejjBZ+Ot
 XyI0tctfDMBeaJCDZA/+ZrzYUokGaHNPI8unMQBqlgZy3XwXSGPQtKG3UrSRD08MT9Ic
 cqZP9fjliOstCct0INfjeunWCYZ5thdM67v5E6jzep1xKyfwE85R0YsGctu6RTAZK6Ud
 fLnb3TuD3NF8TpFXhoudMrd8aTk3LCdnKRJipdRApw7i0ubC2TSM1Jl8JRlkeeVW4VjS
 iBKryjVss13dGtR5zZaRiOfsNdPXn7PbqrMSQmxKO8THKPG/F+XOWqJYQTHOvJHC8pRk
 E/cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=DEL060wEvgC8U6URH92DURnzlVUPhuCzPO1W+gPMu8U=;
 fh=oeIWTZN1iFxaeH/l+6HUkiN98pYzXIn+UbRs2YYcdQ8=;
 b=gGIxHdwmjYoemY2navnMwdld3wgqiwpfwxKsnMBMI82p0sx0u4vjtV1Q24r9MbZRIz
 tnRJ+mSj8Cr9F2JZbkfk3V+ufGab0GfSn3QuwGUZ+VBl/EWjK7XzUHRZSka4udb231rr
 0AeuZoz3MG4woYgpmukkkem6VWwcTrV8Kd8ExCIHOYL62K2Bp4MzeWdsf8RmIN8l5x44
 Yih+WKdag9aYN81OG957OehMmCxazT/azTQIy3mIHHZU51pC2ZjCNY7uqPST6P/uOMAm
 Z5UlozZdZBfhiOZIYmqkKXPqoMaewkel2ItpCEAlhFGz8rtdR/88n5Ll5siYEKDW3omC
 8Lzw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785332488; x=1785937288;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=DEL060wEvgC8U6URH92DURnzlVUPhuCzPO1W+gPMu8U=;
 b=SASKrbwJyMp1yvjhcwQuefbGCdIpH6O1Ibzi2bzHS9QRaaqH4KF31Dz1p5lsyij+RW
 3WgLmyIZH/kR2zIspySpj8t1wmU0v6uFJMKGBSXiGQxB0cDks5EiuPzNajEmUFXX3ImH
 CW1NfQptBa7CcEGP313+5rDZNXg56CnVoHpY2IST5+DOXj+ESZrTw8Fhfht2GTKmLmfd
 CfAC7onzz9smZ+zFHz39/+Qmzz0ob2VpUWMRY/GqxUGIWpTeXl6ztbSXMYbCvkwbubTW
 hzOocmo3ZYxuuvZIdYsoUH7HY2dz8qfXBl/nOYDaVNoeHMzKY82WhRFDxfskUiEe0UNL
 bePg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqXugH2586Zu4790sd+1Ss0XAPDZiusNTIA8fCUEyYr6ruR24WhU189Np6kMI+AmQe78/OtLeM=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yxtz1OmpTSyIlALA9zdnYy7arhTMIF5iIdVmBeeUBgfdIoq0AfZ
 gfl2L5tpBaKN5AvWQ1kIkk9LHoClyoIx/gRQ+puzJ2YhVzuoTl837IrGmsp/pul9t+IXd18StCE
 QHsJYw6IfS77dX2sXWGyIIJizy2lIX1DPS+M2bEy+
X-Gm-Gg: AR+sD10L7i2+KGpqmPJLJMBWiVzSbtwIWW+CSD8D6lNE4Nzl7m/yNtn4m5VkR7X8cMt
 xE8XMdQv68TBUV5Qmv7PkFCI0dEr59y0obQLVuk1Gk1NuTaCzPUYBuQMJFxOrRi8r4TXgnQPaKA
 SEFS6q9nxUq4A2TDe+QkqTrVWkL8rgl3fj/Ukm1lY6cWk9dLVAvmPa3wUiuz6h4HZqSc4oEvLc+
 AdN5PxdDCgp0bDcaGlzGm0k9vGtNP7wLW4QRL9riI0rkE8ozqRUExmWIgwSiWSTOj2BIgmv/zgj
 ycYwpKZ6TUCoQl61I+QVBdmsacQl2+E+ev9JcbK6nLw=
X-Received: by 2002:a05:6402:24d1:b0:69c:72e2:a3d5 with SMTP id
 4fb4d7f45d1cf-6a034a3c960mr2930367a12.6.1785332488398; Wed, 29 Jul 2026
 06:41:28 -0700 (PDT)
MIME-Version: 1.0
References: <734d54aa-6523-4c2b-ba3a-a51b063a340e@gmail.com>
 <ca068b46-0a4f-4324-a6c0-ba56f76c6e23@gmail.com>
In-Reply-To: <ca068b46-0a4f-4324-a6c0-ba56f76c6e23@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Jul 2026 07:41:12 -0600
X-Gm-Features: AUfX_myWX9sEnktYzCRLuyaUIxc6H30Uuao0zPQ9lXun-MrHXMwCmfsuW8My6AE
Message-ID: <CAFLszTiAxsSLFCX=YKgEYScp5qLqQvbqCCX9htur_-jsjT5+mQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/11] rockchip: tools: add comment section to rkspi.c
To: jbx6244@gmail.com
Cc: u-boot@0leil.net, kever.yang@rock-chips.com, sjg@chromium.org, 
 trini@konsulko.com, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785332488; x=1785937288;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DEL060wEvgC8U6URH92DURnzlVUPhuCzPO1W+gPMu8U=;
 b=dxtrjlLlDPmvVlfSGt5r0Edf1NlDWrhmICQsX4xOFilgogqnvBWZpncl0JNbpbhZAZ
 WMOXVBUgQjVCNk8i6CO4Yo3fnqiUz2TSk3XpKSTtMXMTcMQEV/ski3oZabOtuFoCUJfs
 0It4JeUnYgMnBldX9vgLt2PaNpSrbEFEyao1E=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=dxtrjlLl
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 2026-07-28T06:51:38, Johan Jonker <jbx6244@gmail.com> wrote:
> rockchip: tools: add comment section to rkspi.c
>
> README.rockchip must be removed.
> Move the rkspi comment section to rkspi.c
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>
> tools/rkspi.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
