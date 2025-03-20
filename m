Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6034C28B30
	for <u-boot@archiver.kernel.org>; Thu, 20 Mar 2025 14:00:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44CD681A0C;
	Thu, 20 Mar 2025 15:00:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="R8LD3S8/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00C6E81101; Thu, 20 Mar 2025 15:00:39 +0100 (CET)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56A668001F
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 15:00:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-301d6cbbd5bso1443192a91.3
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 07:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742479235; x=1743084035; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Q5t9rikh6MQhf/7sYmyMAmMPy7xYVpfQFtlf6zbcol0=;
 b=R8LD3S8/GPF4euW863vGrYGRuqmLz+RLv/WN1wtq/vtnhpX68BcSItJoZyINby7RhS
 SA16KsTmLsp5EwfEMoGKDFNJfB6E1UAZRqKjJvTPvfn7zU+vtVUL/yh8QGj6W/75u4iN
 Y4RywpzdM1tHeROmZDgKBti7EXSkLCZLsNUJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742479235; x=1743084035;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q5t9rikh6MQhf/7sYmyMAmMPy7xYVpfQFtlf6zbcol0=;
 b=mrfJ3aXJqEbpz/K5inZl7JRsiycZ2q+kzAJRteGom/h2nTUlvAX4KzrsJVGomNgJnk
 1T0tWpajU4Egw//cPY1femsScKQqzNruqGpwlBMyPheeb4XfvqCqXrnnDtKvsoFMz3VE
 8voMstd1XrWqKKENYUmfeSeFln2D7j1Snh5FW0OSuSTzRgZ5z1lQlvRFuielhBGzTYRt
 qli0EwIQb7ufNTlDiynLfO2IrcA+bqJwDqj78FKoMAk5ThcR24q62fXoMaSC/IajKFEm
 mIOSzzM+n+MQ+g/c09/fJIo25KsJ6K1zOZeJKDr57QgewiGViUkBuZk5OiSdo0n7PH8H
 JKcA==
X-Gm-Message-State: AOJu0Yw0ojwA7QVG5HW3NSZDar2sQsdfz27nbaEay+zQhVaJERBTzJHS
 oLBAEnF0fackgY0nSO4G6dxR3ulUNxblhlUP/Ti2kFarabgeBZNG7qGI83VpPV9eGQ8Zc/O9QB+
 X
X-Gm-Gg: ASbGncs5oxnuL1MrL5gsCdLnQEFzHanfBOebk4Ai4wvBN3ebcAVbnjXcFLzeun9oSMn
 hrg1AxLP3C4Pd7AnUHceZl/gWoM8kQ8c5wEIvf6i0ak1QgfHJZg+DFp/r6+LPP+5jZVqg8N1t0W
 L1Sf7nOd3HSBv8zQZ5xuv18eYjHikQXo82vyoOasF1U1EnbUwECd9xB93UIUN5wUZDtzeaUb7fI
 fKM5f4WNt5s7aB04NQb/1aQxj7cpJnbo91IJNDwLrnL2PzV4WurX/YazR7WGk2euzikAwZvthd0
 7JUL6K7WsDqE4fzbmpqoo/KKl+NTgxC+k6LrvnmNn2AxxPul
X-Google-Smtp-Source: AGHT+IEDy5Jas7N9uu8YgmhmwsI2IB9aDR1GWHjk5jhtvjzvo1V8eYQn0/CHF/BD1g0suaLRMsRJMw==
X-Received: by 2002:a17:90b:1b0e:b0:2ff:53a4:74f0 with SMTP id
 98e67ed59e1d1-301be2163d6mr10210533a91.29.1742479234632; 
 Thu, 20 Mar 2025 07:00:34 -0700 (PDT)
Received: from bill-the-cat.. ([187.144.138.125])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf59cd49sm3857532a91.22.2025.03.20.07.00.33
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 07:00:34 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH v2 00/10] Improve pytest runtime
Date: Thu, 20 Mar 2025 07:59:21 -0600
Message-ID: <20250320140030.2052434-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

Hey all,

One thing that Simon Glass has noted is that our pytest run time keeps
getting longer. Looking at:
https://source.denx.de/u-boot/u-boot/-/pipelines/25011/test_report?job_name=sandbox%20test.py%3A%20%5Bfast%20amd64%5D
we can see that some of the longest running tests are a little puzzling.
It turns out that we have two ways of making filesystem images without
requiring root access and one of them is significantly slower than the
other. This series changes us from using virt-make-fs to only using the
mk_fs helper that currently resides in test_ut.py which uses standard
userspace tools. The final result can be seen at:
https://source.denx.de/u-boot/u-boot/-/pipelines/25015/test_report?job_name=sandbox%20test.py%3A%20%5Bfast%20amd64%5D
and the tests changed here now run much quicker.

The changes in v2 are that this has been rebased on top of current
-next.

-- 
Tom

