Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0329AE77188
	for <u-boot@archiver.kernel.org>; Tue, 31 Dec 2024 04:06:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33448804BA;
	Tue, 31 Dec 2024 05:05:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ASmaF47N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAA06804B6; Tue, 31 Dec 2024 05:05:41 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F764804BA
 for <u-boot@lists.denx.de>; Tue, 31 Dec 2024 05:05:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7b6eb531e13so485827885a.0
 for <u-boot@lists.denx.de>; Mon, 30 Dec 2024 20:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735617938; x=1736222738; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lDpes3ujXIXRoyMoI7S6QU62W8xH0J5rEggehpS7coQ=;
 b=ASmaF47N2XnfUYq4ahEYgWX7LBwM5jhFyHcIl3z4bHTJ9JR241TpVjUjIEU+XWcLYi
 ahepVruOefRPOVMCEe4TlnqMrZzbzI0DXHIwFuZCpF5LTF1Wwx1b89Yz7Oq9zc3dHoe8
 E6ozeZ0w5S3rYr5TMsvGL+s05ewaF6tJ0ieFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735617938; x=1736222738;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lDpes3ujXIXRoyMoI7S6QU62W8xH0J5rEggehpS7coQ=;
 b=p0f2QSFbXUVxIo/Yfkc/gOy+F5JtYOhWuoXRpXteY1pnzFDcFJcxHqVvd1aXHVNEq+
 y3p5cQMJwuSASTXuwebgdb/KqP2Krd6LTJIhq+hu79z/gsqVss/srNB1B88DDNHEobuy
 f/s2DwkV70olYL7nsUa2xOkH/W7tWjSdLeDLn7Grzx37Lr+aUGZ674gOsRKE4p3cooCk
 Tp2hjZoaUUnXd/VdvmfP5bbZwnTTo0kyjA0Bo2F7ePP/b4yrOG4Ydphx0Lp9PgO33LS+
 vEIPaCpzSt1Nu5i87HM8e62pQM7y24VfYVIkG2BM42h/ODdNowHdz/n3bl0yKINpy+hT
 sZBQ==
X-Gm-Message-State: AOJu0YxZGMqNixibFyqMs6+EU9Gi/fZQXBBP5DAf/izDj9GSSROnvej2
 0hZUKVZD61LSqX6BiPunQ7osGMLPOA66oFhxptYz8nZnsZPO0kHDn2XShQ5wkFAjLfX7TeA7dQL
 J
X-Gm-Gg: ASbGncuAV2hjDwjeqUwTK9XurTpPf7Cv9wuVJGQcRkEavegbGaeg+ZEAAQQLdTA595O
 iIa58z1nmZhpDRLzY7Na12KdKg7Vo9GiJ6hW4qh+W8sNU6mYDqJkw/uLDPyCQBnUGGoAF9n3HWs
 fOT6OfNtV4MmtjGJeMoO+Br0goVoxp2XMcRpAmIMnJ3W/PUIXdUinkZu8PDHYN10EjXQgeujS3+
 c70U3FLJGospWVKQhMlsH9dJbdfBTLf5XAT6gS0QD0o1ksgcXL3M1dQ
X-Google-Smtp-Source: AGHT+IHOvJ0ZgbX0o0xu3ANQSd/rO0doi2gBnjASa8wA965v/4cZ0nZ275C+azHrC06Mid8SI5G8QA==
X-Received: by 2002:a05:620a:29d6:b0:7b1:4f5c:a3a3 with SMTP id
 af79cd13be357-7b9ba8200d0mr5954692585a.56.1735617938575; 
 Mon, 30 Dec 2024 20:05:38 -0800 (PST)
Received: from [127.0.1.1] ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b9ac480886sm976081485a.83.2024.12.30.20.05.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Dec 2024 20:05:37 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Alexander Graf <agraf@csgraf.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Dmitry Rokosov <ddrokosov@salutedevices.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
In-Reply-To: <20241220035927.3243648-1-sjg@chromium.org>
References: <20241220035927.3243648-1-sjg@chromium.org>
Subject: Re: [PATCH] sandbox: Adjust configuration to hang on panic()
Message-Id: <173561793618.257558.4077129768970930459.b4-ty@konsulko.com>
Date: Mon, 30 Dec 2024 22:05:36 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

On Thu, 19 Dec 2024 20:59:27 -0700, Simon Glass wrote:

> It is annoying to have sandbox enter a boot loop when an assertion
> fails. Hang instead, since then the error message is only printed once
> and Ctrl-C can be used to quit, as per normal.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


