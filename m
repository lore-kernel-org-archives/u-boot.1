Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABF21FF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 18:14:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 452D28469A;
	Tue, 28 Apr 2026 20:14:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="FblNJrqw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABCC8846A8; Tue, 28 Apr 2026 20:14:51 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73F8B8469A
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 20:14:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 110233F858
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 18:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1777400088;
 bh=2+IW5ZWV6XpKdl13CFBbC71aJkeTADsVoKbXwUCbhEQ=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=FblNJrqwt+p3LUKyWha3YsZ2boWm+k7CuHwuvPfBBG2+DjFj4m3e2oIBsmnSvOzDG
 bc5oUCxhr+aM1e3XaOXpd/AXCzQXY8mim8v4yCx7MGdiR/EY40GC1gOyxlc1s/YokB
 snyIjLupfpgJSVpsxksY2K6+DD5SFYtb4L/WLtHgg8c5/jQIS83Q/69xzxOiGouycd
 OXPkMgG7/fSXXwx/QKz5jGAZwrEzyB/mKmOQOOwOp28j8PIroJjzVg0o+KjZBdKRju
 r67TQiVxyleZtK8WbG4hI8o7dBdWX6OpuP1x8LcXeUi0I4UDqN83hMW32iBFu+7ol2
 UYCiuK5d9VGFnw3a65GrYYn+Wii4if3X4KS4oKTZiHiofCaxVg+CRhFuWjSut8tiqE
 knTg3rM1+bssLDsNIAyMoUgMVGH+H1yFHBvnR4VUNBMVlS8Wp77obNCK0yu7lGwu+z
 flexY+frLCwJp8rBI1eUgnZL6T6673W+0bsbtp7Mjqn80S7oe7jX06xBa8juW/5XH7
 i4zUsuJ5lb5R4SNfr5Xv2weofKCJjrYkDYTTwqNWeBRL5YW/bbYC5t8vklVWW6DrSg
 1NqEBJiMLZE5o8i0T/5XEbh/vel6MiOweGZr0gZbR/oKUqtYfyW9Iczm+nQsrWGJdU
 jgxpr+FdlwF7fj2zb12XOrEk=
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-488c0120047so71078685e9.0
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 11:14:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777400087; x=1778004887;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2+IW5ZWV6XpKdl13CFBbC71aJkeTADsVoKbXwUCbhEQ=;
 b=ARblSOJbdyLsBvCggZrlmxZ87F40fHY28/O7XYdYt0AfrsJ521sdI0arQNNXokzhuw
 mW96WhTpQJ8OS2x5Quik9SOaBFJ7wqzPxCi1SFuaUW1wcivhEMHWwohgLUvtEKB/qi36
 HXxXjaGy9bQWYEdfatJu7fas/KGfTZ3IIeeI2PyLXrfMY/CXcEe2JtSvr+LA8jogm+WR
 aToRSTjmF0TTRKSDM0goiuBKJ3FH1YJM5rVGCyqH2wFIwf5bOl0K0RwnB15ioUCo1RtQ
 pMvEmhvLe+1wNKeoY6nrXOcB3x+vMvYOUXn3jirM7MGojR8M3OmZlP3t96l0mh5GNUrP
 OJSg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+bfvID1OiXy5uTcr7ItLKyt3JVaC9ZpZTKUxBMd0Eh6ktranmq/XkpGM9dhY5bh+NlluatkaY=@lists.denx.de
X-Gm-Message-State: AOJu0YxdVIYJU+ic+v4V6wpUWEnhgALMMwcDhxyOdxrUJGB812YG0SxD
 YXWhfetOm3kYjt/Fyceijov2ONBaqwRlUyp2HuNWJqq4zS38e8fkSkJN9Hi96pg299RqTboB0++
 JdGj/Sj7iQ5SRi9qVdvkJi+sqAvzS7ou49kPxuP/RVhGpLfyCr0HH5z59HqfH+GfrcetreUrYC+
 f9YCM=
X-Gm-Gg: AeBDiesn5If7t5kQBpwNfSIUMjR2DjlPIiRumpEetoWpqrTwVf9UWxyNbn4PeSGdmQN
 QJHxS4g6viRQ8PTvGMtxcUBkvTnFcZd4jdm2vbqQhrAyL0MPjP1u3evMH7WdhIs+IuujTVHVVCV
 h/AivA662jMLzyulcupEbtDTX90LQz+qfytrcLiezdiMyQE2aIY6DfIhA62eAhspwO7LLUE9lx1
 frAOLqroAyRf3/Y/u3b5LbPu8/6dynRXnbTiq+M5wrO1XBhRzVVnE6X7wryhG4IPF5Rt6xJyf/q
 KSYVqi35vEYOvlekDOO9NyWOPWGQHisUN8wx9/wLyMAmedizKJd1z6anpHTTggKhT+mpTvgMKe+
 wzYO0eKdsffaUn7B7uXWwShwIq47BWpyWFMkGvfhhwuo2yp9juekxebl2qOi/NWbIyTa1Mj2HPJ
 muLfARd2f63R+R7Qt+1W5HmQfV+cazjnlSYZAwo+5wxqGNHskd5XEGvsyOSByq
X-Received: by 2002:a05:600c:524e:b0:488:ac01:72b6 with SMTP id
 5b1f17b1804b1-48a77b2409fmr70000885e9.21.1777400087491; 
 Tue, 28 Apr 2026 11:14:47 -0700 (PDT)
X-Received: by 2002:a05:600c:524e:b0:488:ac01:72b6 with SMTP id
 5b1f17b1804b1-48a77b2409fmr70000565e9.21.1777400087044; 
 Tue, 28 Apr 2026 11:14:47 -0700 (PDT)
Received: from workstation5 (ip-176-199-115-125.um44.pools.vodafone-ip.de.
 [176.199.115.125]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4463d02f35csm9551802f8f.11.2026.04.28.11.14.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 11:14:46 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Jerome Forissier <jerome.forissier@arm.com>
Cc: Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Tim Harvey <tharvey@gateworks.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/3] net: lwip/wget: correct diagnostic output
Date: Tue, 28 Apr 2026 20:14:31 +0200
Message-ID: <20260428181434.179888-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

* Add a missing linefeed
* Don't print content size twice
* Don't print progress bar when silent

Heinrich Schuchardt (3):
  net: lwip/wget: missing linefeed in diagnostic output
  net: lwip/wget: don't print content size twice
  net: lwip/wget: don't print progress bar when silent

 net/lwip/wget.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

-- 
2.53.0

