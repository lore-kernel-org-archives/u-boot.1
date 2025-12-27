Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D880AE9270E
	for <u-boot@archiver.kernel.org>; Sat, 27 Dec 2025 22:38:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36D4183D0F;
	Sat, 27 Dec 2025 23:38:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="spVvAb+z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE21983CEA; Sat, 27 Dec 2025 23:38:41 +0100 (CET)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D983083D0D
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 23:38:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-3ec4d494383so5794433fac.3
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 14:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766875118; x=1767479918; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U9PyBLVz03WNiD2EAjqAdfBbM9Vge491LuQuseZKkrI=;
 b=spVvAb+znjJJd6KsmTkpE5XSR4qfsRYDr52WzMiHP/9nk82Nhq8kn2joszoXrd9taD
 e0WDL38eb5S7CTSclQ4Gp0CwhWPT9PFBJ9iC99FUBwNOVmNM5JNlLOE//ZMyz8lFTJcR
 Ns7RKmYkPx8u3jHGLY76CwOBaaaQrnysiQuTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766875118; x=1767479918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U9PyBLVz03WNiD2EAjqAdfBbM9Vge491LuQuseZKkrI=;
 b=OwWa7262zduBAE0vB/oB8RVCEu1JrqRIw2IbFvdsfFSacp8y1gkli+gaknBI8zwWQV
 abQLEweEOSTRteVKETJtidX8C+3R0qJRU/gL2zabvJpsBbiuv6fSw7bNA/vgmOaA9lqP
 +7j5eG7h4AgUY3AVPbC+wKJ9BmtJRjLQD89IiEbb39mHw82cSubf7EVSt1rod7gakX5D
 oKLjApABKxSJohB4yszLZeLTEhMtd3gzgsvqUHKjA/c5sFzhE6EMz5LxpdR42jMbA2t1
 3ymAghkLjyk1gffP0GM/E1Pa4N7IwyV/vpU18TOVa/chcTVi16fahaFTEsMNi+u/JCw5
 XsKQ==
X-Gm-Message-State: AOJu0Yw7Arf3RjtEO0ibZ5op/fko6f+SMXtslCBww0cQ0bqGfdvwgYi7
 ptL6aIh/dbz0OobbS7qiKrdAyXxoPWb7kImEqcfP+R4NEqygkEykrr/GLtDPmTZutsk8z9HVrt4
 XJbYa/dk=
X-Gm-Gg: AY/fxX5UywKfCng6BJFwS0aLJp+LKTgFIYFd0H9mLuU1zzz0Ufk2/Il5CfTIrB6JIxH
 fcJWGAIsRkMTvj4AxhUdLoEdkZq5LAFEWfqANPdCJH9tx7liVAM0ueLbJ7iNROaSNPesARKhtrQ
 LQPDY9cP/A/5qZB6uK7B3GLEO2zduzKfYqwI6QZcxGqJyX4/chlnbJAvfFzv8Qbh45ZLauWXeV1
 U6jK6kwmrsVjSkZMhNFn53uAh6et6zgf0LFWMetF6835RTEJPyz912HiuVKYr98DvGbFpvQCV3k
 U2w3kgJ2TgCRd+nP6NBKyTg2T+MZ7iZ4OMu/CR2jMvnbjdYYL41s0VD5mwWsik1LPaoC7nTlQYv
 wfP7jJJUn9u3v41c/RVf1RbDoARLnOVg/OYK0ubfzSAqul/l9foXOkCK0JxNDvHaynqULqipRS4
 B9VwR5oqVeqy99Uf/+nw9oyw54ALDojR/tzsmHfMQcG6YLRLHEqXQYDvjK6ZrtMlU=
X-Google-Smtp-Source: AGHT+IFvJr1cnb8dSDvB/vjKs84P7siJJKBDbiUoihXEz+kNEzYYu+sXAnk3oqM4J3wp1VJs53ixqg==
X-Received: by 2002:a05:6870:6e86:b0:3eb:b2db:8da8 with SMTP id
 586e51a60fabf-3fda58ec710mr12768602fac.48.1766875118525; 
 Sat, 27 Dec 2025 14:38:38 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3fdaab5d61bsm16708517fac.12.2025.12.27.14.38.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 14:38:37 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Francois Berder <fberder@outlook.fr>,
 Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH v2 0/2] Enable / require DEVRES for devm_.alloc usage outside
 xPL
Date: Sat, 27 Dec 2025 16:37:09 -0600
Message-ID: <20251227223833.3019311-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251219202121.4180810-1-trini@konsulko.com>
References: <20251219202121.4180810-1-trini@konsulko.com>
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

As seen by a number of patches fixing memory leaks, U-Boot has a problem
with developer expectations around devm_kmalloc and friends. Namely,
whereas in Linux these memory allocations will be freed automatically in
most cases, in U-Boot this is only true if DEVRES is enabled. Now,
intentionally, in xPL phases, we do not (and do not offer as an option)
enabling DEVRES. However in full U-Boot this is left either to the user,
or some drivers have select'd DEVRES on their own. This inconsistency is
a problem. This series goes and deals with two small issues that were
shown by having all drivers that use devm_.alloc to allocate memory also
select DEVRES and then we make DEVRES no longer be a prompted option and
instead select'd as needed. We do not make this unconditional as it
would result in growing the resulting binary on the many platforms which
have no users of the devm_.alloc family of functions.

Changes in v2:
- Patch 1/3 has been merged for other reasons
- Patch 2/3 has Bin's tag now
- Patch 3/3 has a reworded commit message to try and be clearer about
  the problem, fixed a typo spotted by Michael and adds his tag.

-- 
Tom

