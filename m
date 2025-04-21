Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA8BC369AB
	for <u-boot@archiver.kernel.org>; Mon, 21 Apr 2025 16:00:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC6808171B;
	Mon, 21 Apr 2025 18:00:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jOPUCyRj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A8BE8192A; Mon, 21 Apr 2025 18:00:12 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 919C28144A
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 18:00:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-400fa6b3012so1955772b6e.1
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 09:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745251207; x=1745856007; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1Wp3hiS8oTCrNkKzwnFOdxgWlSenVYOVBU2PLVA6drQ=;
 b=jOPUCyRjhIR1EBrqdOjAo4kGgyZPrKfnUOO0BTNVMmbQtlZ+VgA0oY8c77erSPkbGg
 Zjxlmhz2NXGUWjOfwAukVkJ0AAiYrdRaL/ve00nI+9f1ijNbeBq7HeTsmk3lhLySNzIC
 rMX4Ja5DjhJFdWH8Y58M4O9zs32xAT0jUZjcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745251207; x=1745856007;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1Wp3hiS8oTCrNkKzwnFOdxgWlSenVYOVBU2PLVA6drQ=;
 b=G8M8zhUti58PKr39JvWX3NgRPe6tWzCjeju5jX/rwS9b97tpIstN2LEdASblzmuX3i
 GVtywsm+zZh+zxU0FHOOFFEnxzjNDrfqg4hEjp7uPUd+mOrphdrz+Z9IwPpvTyBT/YNT
 jwsRgIkx8Vc+vvZPhoesQ7LWjHEdJYWNC/Re8orWvtJylAr3VQ4YegzO7G0hD5ymyBan
 QkxLeMgiuG7+30Sk8GOMPrl6EKLNb9IYt0tif/BEdmgX2abAG1jlUh+Bmb7ItjZ8S+AK
 s8PnDfQJiqkYKMiICXQWHQ7HIyLZWfMCQkHmfGr4ChhqhPdObEsgXrIOvZuo78VMiLpS
 oEaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWc2kb3vokwiN3uWrDfzUX1Jn1BrTqcOceEt1SF+hrhfk7zCsHhVJ3xJPEM8KVqMK13O5ym4oc=@lists.denx.de
X-Gm-Message-State: AOJu0YyfsyTPhsomEFLr3N10CLzgmZ2D9s7XleoJ3kHTYMpmIrG79rdo
 6Xz2Q8JWib53Pj+R4TW+5eZZPd3WB3KqeTcHH32V3eOlrFFB6oBn0apHeOANeIzCdzD1pk506Sl
 H
X-Gm-Gg: ASbGncuXw/xzUEJ+BP45O/3w1ZJoXVVYz7Z+zWWc6j9UZ/UBaLnKynp1wU+fX/JvtDz
 KAA4ah6SWO8sKB7MI3YmTD35+gBq3D60mf65L7C4opa8qOJbFbz5gPy2KnhCXqNnmL/lAb4Isf5
 3G+nuNHZiyKO6ovNo3CaGDwj0w2qZDj98BvHwGLntNTvGwCF06OcZl+EvDzYKkEvaCizptIwodp
 YCqJp5oKmH+vj/Wsy2wXeQhg7NEX2GVQdAFx27IrmAm5u2CAW9WREWuqUccTXACVHYxRqJPv1qy
 YWv1Hr5ZvqsEw5DnuDNAkjsG28R69SFrj4ZiQ4XSAONMiGmL5F/Xwz0ePy1ywJtdCxMkFC8sY9h
 j
X-Google-Smtp-Source: AGHT+IGh5jNlcYJEWVckfVjMn1cEk+PLFsoX2CTjbQcmczA2Bffd164/JpZPPBxr6pGgfH6LvW2sFQ==
X-Received: by 2002:a05:6808:6907:b0:400:e771:ab80 with SMTP id
 5614622812f47-401c05db228mr6786710b6e.0.1745251206479; 
 Mon, 21 Apr 2025 09:00:06 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-401beeec320sm1580204b6e.25.2025.04.21.09.00.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Apr 2025 09:00:05 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: tom.rini@konsulko.com, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Peter Robinson <pbrobinson@gmail.com>
In-Reply-To: <CALeDE9MCh+ZT7eZYJwGwn-mWnDFDBE653c+7fHT-gpJnrXgjdw@mail.gmail.com>
References: <CALeDE9MCh+ZT7eZYJwGwn-mWnDFDBE653c+7fHT-gpJnrXgjdw@mail.gmail.com>
Subject: Re: [GIT PULL] rpi: updates for v2025.07
Message-Id: <174525120560.3501265.852747693674623635.b4-ty@konsulko.com>
Date: Mon, 21 Apr 2025 10:00:05 -0600
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

On Mon, 21 Apr 2025 11:01:08 +0100, Peter Robinson wrote:

> The following changes since commit: a08425586799374ccded78eb5fdef6e2235e1ad9
> 
>    Merge tag 'tpm-master-14042025'
> 
> are available in the Git repository at:
> 
>    https://source.denx.de/u-boot/custodians/u-boot-raspberrypi.git
> tags/rpi-2025.07-rc1
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


