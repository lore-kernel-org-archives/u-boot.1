Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7829CCFA04
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 19:05:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8651D835FE;
	Tue,  4 Nov 2025 20:05:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="esjXZP4M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 823BF838A5; Tue,  4 Nov 2025 20:05:07 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 688E9832AD
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 20:05:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-4439ecf6004so72094b6e.1
 for <u-boot@lists.denx.de>; Tue, 04 Nov 2025 11:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762283104; x=1762887904; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XCnie5i+4sRCTwdcPTVno9NVwEupaXme/fQkBg49WA0=;
 b=esjXZP4MhSbD+adKzzjW4+dWhGc24e31BnEi4irM4rWX+OPU2YkthqXp6QOxbykXQR
 kJiJOJQRxk5b5f4Cq0rNVVks60tOdMU33lg7NXVhjeEPwVW06LD1HIGAGDHGhMYY9OJE
 gPQRWo/3IAnMZCRD2OPzXHUJlFViIud5McchM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762283104; x=1762887904;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XCnie5i+4sRCTwdcPTVno9NVwEupaXme/fQkBg49WA0=;
 b=EY0Cm8zbKU4eqnRMadv5AvFc7pnxRuBQa4pkMhwTdSsb9YRkSXkNIoc1ln5oXtM4O1
 bap+RiXk8asj8gkWDjESzD3dmOp21TM8LdN84u1s+TvoKejqKPjSRxKzc6e3CRldRu0G
 mN6bzBRZXpnI34Y8t0fZaMIL022b0110QaKcVcLIkTMskHrWwz0utMxI/rcI3UcMMQmQ
 hzYrgXOj+uM6PMaj1DgdWQ573mITjZPkU/XKuywfUPAKTEs+yOJreNB30wU0fHcNrzWQ
 IAUMtZt4st0JRxdjlztK/prphdjB89/9iqCPkebROpzfXAyAm9hGHZ/yTg09KBsmja9s
 1zYg==
X-Gm-Message-State: AOJu0YxLaPTjqiwyEFucGLyq6V8AOqRUTXBYYVioAeBvWxplWw2NdgbO
 syjs3Mk1nzNqmPsxVK+6NPEcoHZiivCJ3eI4EvanM8vYrggG2q4z6UiuYsSsQSfqT1OYZP76si8
 oOHaracG48Q==
X-Gm-Gg: ASbGncsTXp5N2xMqyVJsOp7iAINvxkq7/wfxaEbLJLuMmgt8dKlWYByCRyzjbY37gOa
 CpXQfpTnWTlqJZk/UaFiaJSi0JgocGQTXm8CblOhGZy9FthK+NbgWKcv1aoEFzEQWRkQ1Qwh3F+
 imOk+4lG24y60aqZV7wcr+sNnlVgsvUA6OAI3FrKczYMpsmZfGa6UzvxjqHMuF0x/7p0u/jg6gV
 AgAG0jjzAZXtYrERx0JvsWIQAZg0nuftRrBcA5yjZJ/p89kPv/U4CdOKDgxLs0qARVbGul3LCXV
 V00lP4RhtLZmubW6oJ3tenCEzzN1muzBjIymNdFtb3/6deloqhXGNpN/kjLXDHnqQTaoggS0N5x
 cgFIVshWoJvBAezkp8/m5qJgRJuw6P12mEpq+qWLhdypXKTtRwC5qXBmm2ToFpIXewXmeaU4a8u
 BGNY9KplKez8lHhs1x9lZG0lYTEjgdSV2XoDI7cQ==
X-Google-Smtp-Source: AGHT+IF5JI5oLL3pP6kh9CD61StdKXdcZHVnwjE/9qVFfpnqydox58jVsLYdFgnX0jfbCxT7ek6XFQ==
X-Received: by 2002:a05:6808:6f87:b0:44f:b05e:2637 with SMTP id
 5614622812f47-44fdc0560b4mr1946880b6e.31.1762283103903; 
 Tue, 04 Nov 2025 11:05:03 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-44fe4ca9d03sm352611b6e.24.2025.11.04.11.05.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 11:05:02 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
In-Reply-To: <20251029134833.137965-1-heinrich.schuchardt@canonical.com>
References: <20251029134833.137965-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] Dockerfile: remove Python 2.7
Message-Id: <176228310235.3992564.14541939100672418499.b4-ty@konsulko.com>
Date: Tue, 04 Nov 2025 13:05:02 -0600
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

On Wed, 29 Oct 2025 14:48:33 +0100, Heinrich Schuchardt wrote:

> We don't use Python 2 anywhere. Remove the package from our Docker image.
> 
> 

Applied to u-boot/master, thanks!

[1/1] Dockerfile: remove Python 2.7
      commit: da7942de29f7f033a676a099335b16ca9b0226ab
-- 
Tom


