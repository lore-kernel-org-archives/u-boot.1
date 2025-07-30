Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98449C87FCB
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 17:19:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC5D1830F6;
	Wed, 30 Jul 2025 19:18:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pozu61uR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 333B48211F; Wed, 30 Jul 2025 19:18:46 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EC9082D32
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 19:18:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-30194d82366so75337fac.3
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 10:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753895922; x=1754500722; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cY+Wc9u+C6/01HBbfA7/6yv9Pjdmadl0xZT2X4l/HDo=;
 b=pozu61uRrGIu2/MflRMi75SpE3UAPXSa2//kpUxz/2axaRlZwNes2q6mk6AXxYzsaz
 h0on5puAPo4a+ADq+WmSW8eBhNEHqugqdbbdLIvDP7H+AgX7tfcJb/2zozqOVNrmjSvL
 IKn99fBL0PeJp45kJglBT8Tj21D2QxLunNpDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753895922; x=1754500722;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cY+Wc9u+C6/01HBbfA7/6yv9Pjdmadl0xZT2X4l/HDo=;
 b=B4NKRWy+7DlXZIxNrUjZTi2FB2IkS4IpluKqif/h9kV9q5p1Hs7Kc7RnFZRnHiQrj+
 gwQmsKQF7JhmMnTuyTIqaR/NObQkV2kz7uaSkOMBI6NuQE9Cc39uFIXBJnSNv/owa4DW
 DA9q0YwbsbH+cuk+gHWLkQ85UdsIveLqv0HR+GYSwnkywcyEomezHgF/OzLJG8xO/vWD
 +T1ubtzaKzcQ6RB3rAE5oHwnPZckGS27zuhat1HZU4ESuozKYKTyxyqex9pmcRHhQt31
 fKRjFVqYoAn/xyn2nZqvTgoUSXYoDgML4TNPS84twtCZTaLjKM/lWCRcTT49kiCJRmdU
 D61w==
X-Gm-Message-State: AOJu0YzXkJ4+vuVHX3nvzGWjEEh6y5PjJZClrpbPNGLesN3EEHx+ML/s
 MTckOaMePsHmssPTCuSwOqZ4i/pEccSNgv+FsYbSepX+nbSkvqoDGNzytOLHA3CI4ugatsidZc9
 BKZuf3g8=
X-Gm-Gg: ASbGncuCOC3xHbzhtRoz8AAxBVJfL0VR8Smh8/zPZxWkXGpzU15EHQKyMnp5Wc/hsRr
 Ey5WA+URJoINjrOTr6rhj+kFBQU2rRUXKzicmkoyFdfeCioaOvW9xl8a5VXVcSRhzIzE1fJ+fNv
 bODLe307mlichVIM7WHrv5HzcFwaErmVZf7r4ivxroqip2+MnG+jOel8cxZI7I3s3jLjmmvxUYp
 2vnhE78VFDA4FnsRDfaSBObR13n0lWzJy2zxKupo8n1LbT1PTt0jWj0RO7O+GN+QJ0OgObFR41L
 XA0E78vcr+DdVVNspi2+M8NM43XL0TqVhiSf8F7sdIPWSNKDAQyzPmQwJmBIx3JTLEp87r1XABJ
 7QU86lOF2UQ9+dcN7U9ZAw7yVaXtBzfNUsCdYAQVT/k/a5Xq6h10c92U=
X-Google-Smtp-Source: AGHT+IGcsKA+1XO/i3ESfiXDFMBeKWuy4FiU/HrORsFm54pc1UPZqL4we+wljtFxV1WrDk0Mp31hGg==
X-Received: by 2002:a05:6870:169b:b0:301:a704:ef1c with SMTP id
 586e51a60fabf-30785c11177mr2561064fac.25.1753895921801; 
 Wed, 30 Jul 2025 10:18:41 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3071323a99csm3016751fac.12.2025.07.30.10.18.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Jul 2025 10:18:40 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <84e083b7-fe7d-4067-919e-b3a64c287050@mailbox.org>
References: <84e083b7-fe7d-4067-919e-b3a64c287050@mailbox.org>
Subject: Re: Please pull u-boot-watchdog/master
Message-Id: <175389592069.3621398.1808740839347097876.b4-ty@konsulko.com>
Date: Wed, 30 Jul 2025 11:18:40 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2
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

On Wed, 30 Jul 2025 12:17:26 +0200, Stefan Roese wrote:

> please pull this next batch of watchdog related patches:
> 
> ----------------------------------------------------------------
> - watchdog for STM32MP family updates (Antonio, Clément and Patrice)
> ----------------------------------------------------------------
> 
> Here the Azure build, without any issues:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


