Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A31E77188
	for <u-boot@archiver.kernel.org>; Tue, 31 Dec 2024 04:06:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB60E806E6;
	Tue, 31 Dec 2024 05:05:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cJomJTWJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 296DA804BA; Tue, 31 Dec 2024 05:05:39 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B036804B6
 for <u-boot@lists.denx.de>; Tue, 31 Dec 2024 05:05:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7b6e5ee6ac7so755922585a.0
 for <u-boot@lists.denx.de>; Mon, 30 Dec 2024 20:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735617936; x=1736222736; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ITz5v/1juxDj72Z0LZnBQOJTuhoIooRc7HNHUG2Rixc=;
 b=cJomJTWJREOJ7odNjLB51pb0GpMhqY+n80Uo4DT4MGte4MMDGSwWF+0GuYbjDCHTcA
 Qsxl/vVonKPmMxDVL6s7bBAzYcE/BlngQ12EYEpx8fCPby6plNjO3In7u3zJRqsoMkY4
 7T0ggpdQwRViBzUtNcdvKjzXeNw/jELmjgIyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735617936; x=1736222736;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ITz5v/1juxDj72Z0LZnBQOJTuhoIooRc7HNHUG2Rixc=;
 b=F3493guSp8qRm/6Zisl8erWQck6TseAnrYWVSnCvv6scnaa2gukzh/PhpfLLfXctYE
 zw90Zm79CUuA+B1AybEh1hqds4rKbNTFFIAvfy1CyYCxmrCTnq20IlhmqDrTnijRUGDe
 C0aT2deVSwHfZeE0fAGuPtKZLtBpCuIEAPK/L/znDF5kXD09oBkV+wNqXhWXr8xyNUcw
 QQWO3sP0vgW1elaQ9YwYKkTIQ5jGSU4ROUpKiCxT2xP11xXylB2SEninxW//5MQBoWqc
 /tVvR5ZjGZ/4xRAGkS3t1mZMase/F6XjeRn8cHhfbGJDlhHrmWqrYH8r6xrh/SADdRq5
 qn8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLWr/fmjbODQf1UApis3lzCVodnh8NbvjcIaqq1lMEHMgItSFkQF0geiJMiBujEQZMW9avDLc=@lists.denx.de
X-Gm-Message-State: AOJu0YylpKCop75ANzElXGwijObmofjvg/7cTOeuF96AjOKW7mQW47Aj
 Idbly60dZRZuSRT5hBpt/wlKEC5D9AXpeEVwr1vEEVfCvjbmaqY5AiqUbWESXPg=
X-Gm-Gg: ASbGnctiTBxkOesgpFogiRTpXDzj/tNbZ+iUVahdbayPwXOC8UHq8L8HBVSvd7uC+ze
 IGqahx5fPyeSGvULxUdm1LnD7nhm3+iKFn1gmbJ5I6blxWajEkcGOgidzYEMgDI25hABo0icGXW
 dPR/QJ98FjIda/iUfCZk9qbTRy8YxIqHJcTNRoqSqGCdw40iB2yME52yXRoPCuMP92mUJbVrvQi
 fAI3aihWC1GTcqZKzHgnCYGY1b+5NizvB1NAVOFO3TWga9ATH4M+syf
X-Google-Smtp-Source: AGHT+IGqpQ6DsNb/eFojA+IvMzO7flSI+XBAZKbHtMvp2oa80Y3Uuq11iwdNAJo2Bgrm62P3BKY0KQ==
X-Received: by 2002:a05:620a:27c6:b0:7b6:7a7b:1a4 with SMTP id
 af79cd13be357-7b9ba7a38bcmr6375740385a.27.1735617936006; 
 Mon, 30 Dec 2024 20:05:36 -0800 (PST)
Received: from [127.0.1.1] ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b9ac480886sm976081485a.83.2024.12.30.20.05.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Dec 2024 20:05:35 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Mario Six <mario.six@gdsys.cc>, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Cc: Sinan Akman <sinan@writeme.com>, u-boot@lists.denx.de
In-Reply-To: <20241220-mpc83xx-misc-v2-0-ff4c17ee5fa4@posteo.net>
References: <20241220-mpc83xx-misc-v2-0-ff4c17ee5fa4@posteo.net>
Subject: Re: [PATCH v2 0/4] Misc. PowerPC MPC83xx fixes/cleanups
Message-Id: <173561793412.257558.8520699293797948641.b4-ty@konsulko.com>
Date: Mon, 30 Dec 2024 22:05:34 -0600
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

On Fri, 20 Dec 2024 11:37:50 +0100, J. Neuschäfer wrote:

> This patchset contains a few small fixes/cleanups for the MPC83xx
> platform.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


