Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C086760A2603
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 08:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gtz4Kunl;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hk5mQx+J
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 85BA680F86;
	Tue, 10 Nov 2026 08:46:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DLGtZBO_ACOI; Tue, 10 Nov 2026 08:46:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CE64780FA4
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794300396;
	b=rtbLkuvEVMqKr0rGoC+qL1Oex7Mi1beYXwiod+CioDivCS9f7d4oaBFQOF0RD7PEABDs
	 dNUxCaRIYLi4jtAYKYJx8erTK5xF/urItcy5s0p1o3WcMYKedjKlP5OoZ/VZl9HeE/KII
	 VFxgjN+8KuuyxfJd0NHrZ8Q4aeAS+iJ5+QHqNAYRFwXsWovZ+D6M83S2dSRQ1FGhRyKGC
	 5w58d7ZjCQItWDMWJIYxkqahHr73DzqQL0OD7mVlyhQZRRX82r6TdNg6vFx2nZlvh0jWB
	 PV7+dRUOy3WDH0y1V6ECyGK6zJoYWqNebMZaH6sapbnBf91GmZxXLXC0UjXjdkEi86w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794300396;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=kwqXErn/L+FlabPSQ5DL18WbZIfpaV4NPUaT6/CDhI4=;
	b=G0uNPCsjz8k8Ev8NMGxXj1gs9l9fjvohm6Zm0xAWObhCfqN24M1RUc5Gr6p2MwxULLxR
	 h9cFsQzvTJ77DuuOC3kwosUYKbawTUj9Te5XSOOnqOOSrKvKn9/VNxLqhdu2N0D4/KMbY
	 1ocqSQppIn8TxzLPgyCJoMhGc8m9miNIcYE1v7nr+Ood3jOld/0bXeu7vCnRiCSTvquFC
	 4umu7fJygv0Cz5g1MoCiJps+wNZifDuCz8wAiyc6p33upAZrIBY/WHC/SaiJcQPZ65TD9
	 u1LigG3vfRIEK3qDEuQBqEfyNSW5rsWdwNrGtz1r2WJFKkwM2M4YEbzq92y885SeHAQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hk5mQx+J;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794300396;
	bh=kwqXErn/L+FlabPSQ5DL18WbZIfpaV4NPUaT6/CDhI4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gtz4KunlBPqtpRwhSSK20eHQHrFuPdt8XMIO8E+He0HWf5pHRjDrb2eRyNeMXAO05
	 D4ouRUAm2HIpKOZ0QMMiC1ZimUL/OoyCkJY+GYTKlWs1YLep/BhUK4bxGUozzI3ZGT
	 y2PKydN3nlok7lbNp6KOk8RQQF7JfeumzMxJDnJcVIb0uYRGN2jpa1W53N0+EpbY9C
	 IKKUi5dYL6kLg1q7ZE+HWyuVz5wg6L/GoFIDg0XSFkf3RCSr0FRP5esYCn66dzYiuO
	 XN9q3nrcvrMwTrLcchm8rp5v02sr/wayKIX12IAuZVLQZIQ6Jp5G6hiTMczFzGcS+y
	 +Zia3cIOYDAIA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CE64780FA4;
	Tue, 10 Nov 2026 08:46:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8C614335
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 08:46:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7DA9C80FA4
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 08:46:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6sBQRaA7u_pZ for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 08:46:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CA74F80F36
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1229"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1229; helo=mail-dl1-x1229.google.com;
 envelope-from=clamor95@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=hk5mQx+J
Received: from mail-dl1-x1229.google.com (mail-dl1-x1229.google.com
 [IPv6:2607:f8b0:4864:20::1229])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CA74F80F36
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 08:46:33 +0000 (UTC)
Received: by mail-dl1-x1229.google.com with SMTP id
 a92af1059eb24-1b3a05f8b5bso2695184c88.1
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 00:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794300393; x=1794905193;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kwqXErn/L+FlabPSQ5DL18WbZIfpaV4NPUaT6/CDhI4=;
 b=hk5mQx+Jqu7ycV0euq+cLJsuxfSiRawsHKU0tzKCtNGv7Im5IyWYg51HHGHbJWX0Se
 JhIxxHnENxdmhVJnSax1efHF75CP76m8zlxQRSPxFqQDk0+mtSwUpcKkuzlVbNP1hZW7
 54lICNyqdSSSjEzCs8V7pFbJKTfflQhado5TuEhI5q89noceTDXHWU9YcL9ar5iz4FbK
 NtGeJhSUCYDigHjY8YwHX6O8D5vHTHM6y3+a+LTz0QSUYMRiVWMb14LPkZ+LBuGR0hdH
 KzyaJ4rEBAoCqQ1P90ptAr8zzxkOC9vHcOTvwT1F5y83bHkAiCXNvHWiCXuaDqgd4PSS
 Hsmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794300393; x=1794905193;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kwqXErn/L+FlabPSQ5DL18WbZIfpaV4NPUaT6/CDhI4=;
 b=sIupJ7A/LjM9EtB0wa6GWLCRwavc5AW3K8f8p5+olFwUnZB7g7bbFYz2UwxeuCmxS3
 HZ5UQWAhe/LWTJIDhpDn3CXMgk9AcOd2YAWyJrzVv3CZyOm04GgUIY+sCD16FUQys5Eh
 XprhXYW09ZW3CoUjJaUs5wizj+XvgiZmehxIBpL11E5LO/qFl8derK9A31igPB7lgbu7
 aZkFdPYl0kNWQMHAz4+aLxDToV6sF3tl9s3n1t+XozizmlMBgP/O50fZVW5uqfYAzkcb
 8MyfKhEAMEwSkYAG+l10TdWIB0aACl7O+a87O9gJdPzIZ4f7DbvzlCsAR4dqwRKCs0Ru
 4w3A==
X-Gm-Message-State: APuU4Z+/iocauniLTHWfQFITiQvkIVi7Sx4WOgbjM8JsMHu4D/pfqfc5
 8kJF5PzajLNxvtID7TpjrK2uXvJKIuuxyy83wSkapSxUcAggqzs6blobg/1KdqJEeOPF2P9SOq5
 nJxKBaAYQ0xXzEi7ULcj//SfvQi7XAcETxA==
X-Gm-Gg: AYBFou3owtNXaMwZl57gkNFkXpCHLuzGLNsbJBRUO2hPqyeXT+ejmXqgaHkiA7wm4ie
 yOmPtsjrTEhEPcgbOMQqUpHeu+FWzaMaI3mlCcg72ulGHYgJymwJGSGdsnMxPpGEbEVGwQZmJO7
 pTDwqlDwOrqQwqzOsQKmldFWM1zR5lVENS1r3b1wnuqxcgSKr3oIl/83No8V3J1i+jSbKgN5fia
 2PD8yZV3gfGSVSlifZR6guKbKCARHxprP7c9A7YRuk2y1nLUBJzn81DluUIQj3Bbn7kiw3dBOJP
 /o1j4jxl1vymY558Gq412Txu+V1odnGo0uoKoKyNkE7hORqkAUU7tscthfGpG94YyN6j9C54tiX
 aMeG14eNR7yB/rslXNVuZbI+CjpIXEnvmti7Yt/VjOZa5bQV4m5i5laOnI4Kl33wGgWd6wBArKv
 EDEtpmZFa/T0n28N+I00rcMX2C9vrbig==
X-Received: by 2002:a05:7301:430c:b0:36c:3b8a:8090 with SMTP id
 5a478bee46e88-3751c53f42amr2676825eec.2.1794300392488; Tue, 10 Nov 2026
 00:46:32 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <2399d63c-ddd0-44b0-bb81-d5d9d2a8a8b4@gmail.com>
 <ab368609-f5ab-4169-9c53-c9590766cadf@gmail.com>
In-Reply-To: <ab368609-f5ab-4169-9c53-c9590766cadf@gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 10 Nov 2026 10:46:06 +0200
X-Gm-Features: AclHuK_F8OTxL68LzSCU7AphyCwPJTtTd3XuQXnz2K5N9_Ha6Y5nYUUmkKpxqIo
Message-ID: <CAPVz0n0dOk3SjWZZL58UpQ-0NGTO0ZbXQxz7W1GCWPUdMXdjQw@mail.gmail.com>
Subject: Re: [PATCH 09/11] video: tegra: hdmi: Skip modes larger than the DC
 frame buffer
To: Ana Bobillo <anabobillo3@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Kever Yang <kever.yang@rock-chips.com>, Quentin Schulz <u-boot@0leil.net>, 
 Andre Przywara <andre.przywara@arm.com>, Thierry Reding <treding@nvidia.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 uboot-stm32@st-md-mailman.stormreply.com, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
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
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

=D0=BF=D0=BD, 9 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 19:29=
 Ana Bobillo <anabobillo3@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> From: Ana Bobillo <anabobillo3@gmail.com>
>
> tegra_lcd_bind() reserves a frame buffer for LCD_MAX_WIDTH x
> LCD_MAX_HEIGHT, and the DC takes the mode its HDMI bridge read from the
> display's EDID, but tegra_hdmi_mode_valid() only checks the pixel
> clock. A display announcing a larger mode makes the frame buffer run
> past the reserved memory.
>
> Move the DC limits to dc.h and have tegra_hdmi_mode_valid() refuse the
> modes which exceed them, so that a smaller one, or the default 720p
> mode, is used instead.
>
> Fixes: 2dd1092ab887 ("video: tegra20: provide driver support for the HDMI=
 controller")
> Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
> ---
>  drivers/video/tegra/dc.c   | 4 ++--
>  drivers/video/tegra/dc.h   | 4 ++++
>  drivers/video/tegra/hdmi.c | 5 +++++
>  3 files changed, 11 insertions(+), 2 deletions(-)

Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com>
