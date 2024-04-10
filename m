Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 576F4CD128A
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 17:44:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5758881C8;
	Wed, 10 Apr 2024 19:43:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rJ7TLZZb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86CF6881E6; Wed, 10 Apr 2024 19:43:29 +0200 (CEST)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7945487D8E
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 19:43:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-78d57bd577dso335937685a.2
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 10:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712771006; x=1713375806; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TeGC9xZ9hFuI9HUX8LvfXHfbDla7b+n403WZwBpEqfg=;
 b=rJ7TLZZb+dO5vushYURm967jDZnjjVwq3lhoguog6DrSwNq8FcmDK2EKjDJ7p3PcGe
 YwDVOyfcRqF4Ig95dJv7wv4hmb8IUY0+9bhcwc5WiLf0hrZ1TEQiXfka5SS00RpZuOu8
 7kd5SI0bwhAqMg6nlOLAi1VdjX0slYqLLoEg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712771006; x=1713375806;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TeGC9xZ9hFuI9HUX8LvfXHfbDla7b+n403WZwBpEqfg=;
 b=f2ZhkKKq+Jie9mFQD65s3YMSXr5QOIbzDRuOQHnbcvsdE3eXU8qTI00Tqfn0eLQ2cL
 ezbzIUKZ1nfnuZyo5pxIccnAsemVIES1jLFpxv58U0Ah8SR5SPaOJ3LCMrQauqv/+mXo
 XW4/qnLcMeDy8EqXNS7SaklW4g+Ld/If10CEB0/46FsOYvfJvjgN7s191fQXaISlj+l8
 OXQVHgsSq/ug/Q20oOTcNxNlxah+gRKD89o7ew1DesDyXwryt9kjFUxIyAImUyTsP910
 +jXWPd8QzXPjhLOrKE+vqfdgBmtNvKjOcHghPH3Rt/oYF/yhAZuNdIVSb9cok5mvd11/
 xP8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnmkIWW89us1kaMXKj3H7yqklAn5/FuOWylAyl8AbkOJeZ9nNq08Ydx41FdQxiU46FGyVyJTUdaP255LusjrD3P+MktQ==
X-Gm-Message-State: AOJu0YyaMmxQjqE3MvYP72ZSLzg+dOjitx4llPhDNMxOHZ6hYwefqJ0C
 c/Nfh8hNTJ7EZ2zdDEU+i0sj5KQSZol3L7tlF3QHxMVCXip15v+bhasUeRDQ8WtesfVlAB7etd3
 V7L3hfw==
X-Google-Smtp-Source: AGHT+IHwsJkBMjVWiEEVWkj1RRidCSwEFZgD4cM7rAgP11S5LwBLySeZR1wbJvLXhDbZxxMm9VmONw==
X-Received: by 2002:a05:620a:21d5:b0:78d:46d1:65f3 with SMTP id
 h21-20020a05620a21d500b0078d46d165f3mr3360652qka.12.1712771006191; 
 Wed, 10 Apr 2024 10:43:26 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 vq3-20020a05620a558300b0078d6b676b9csm2308177qkn.17.2024.04.10.10.43.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Apr 2024 10:43:25 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Sean Anderson <seanga2@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Simon Glass <sjg@chromium.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, 
 u-boot@lists.denx.de
In-Reply-To: <20240327080927.21401-1-heinrich.schuchardt@canonical.com>
References: <20240327080927.21401-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH v2 1/1] fs: ext4: all file paths are absolute
Message-Id: <171277100504.98421.11262035649628810966.b4-ty@konsulko.com>
Date: Wed, 10 Apr 2024 11:43:25 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Wed, 27 Mar 2024 09:09:27 +0100, Heinrich Schuchardt wrote:

> U-Boot only knows absolute file paths. It is inconsistent to require that
> saving to an ext4 file system should use a leading '/' while reading does
> not. Remove the superfluous check.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


