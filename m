Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C64C5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 19:53:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9154D6067A;
	Mon, 24 Aug 2026 19:53:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mAXeD2-coLf0; Mon, 24 Aug 2026 19:53:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787601187;
	bh=aiSGdTRwJeumRc15+4xfQlATrjID1tf281m7hkwXYgM=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kFo9E/bMeLQBI0Ko9RCUsyAw9cGJEYOP01Kj9ZOIEEKGdm7iBPt02lBskJLb632lW
	 ZQY7b9KgA4cnhCwTA7aNnvocpdepbFOQr1Sb1AnJ0QtKUQX38FGwFJG6PwzPE5I+uP
	 8PWf8tmH50KwFpjBzLsSLxGm2zKwhCp/eRWWu/xGIiBql3YEvsMV/pj3r4qUeqC3ki
	 J4QQXdUibYd8XBjfltaXCeGLTtUM8jghzsY5Y4/em/Mpf04xgZVGOn42nnvwcUnfM6
	 R9BxMXP8QjGlYw6REmC/7IqpOmsP6tSfTR9Un+CliMXk5rd+c7+Fh9MJ1AnoJtcAYI
	 V/4NtwyQfAMfQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9667560624;
	Mon, 24 Aug 2026 19:53:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2B284279
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 19:53:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1D97080D43
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 19:53:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0r3ycR1aFVM9 for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 19:53:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::8;
 helo=mail-oi2-x08.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=g7v0HUB0
Received: from mail-oi2-x08.google.com (mail-oi2-x08.google.com
 [IPv6:2607:f8b0:4864:32::8])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3101580BD3
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 19:53:02 +0000 (UTC)
Received: by mail-oi2-x08.google.com with SMTP id
 46e09a7af769-7eb5203bccbso160765a34.0
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 12:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787601182; x=1788205982;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=aiSGdTRwJeumRc15+4xfQlATrjID1tf281m7hkwXYgM=;
 b=g7v0HUB00AJ508V3O5aFNDuS5I3f1cb/f8QExQu45eI8BslaZjpHIzYaJIAOqgzGoB
 yBdjX7pSAc53aEcLq/dJ4BJPQ2QIEChHJVAUlteAZrFMfYChvthEohgQwrHeLmwgfl0Q
 pVLiY1L9sINOChbC+Pp6hM0MKgdIVrINRjlto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787601182; x=1788205982;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=aiSGdTRwJeumRc15+4xfQlATrjID1tf281m7hkwXYgM=;
 b=CyeAbDlrY8wEyrasRVx2ASrBJ6z77UQDl6KoKBYcBQ2WxHUS+xc0H/LyzwljxyQilm
 RQSmoJli/dlVGOmz5I7GS5yF1Kou3xpmxuxZsMoTRAJyUOxkALg1H0VwE/az0in70D/F
 nbU4n9hGlBKQJQkgWQQcAVlJft5ET6nTgd5YNe3bDxRkOvaxVLzrTer+2XUBTwk6ngDJ
 5kXTfr5rTfI4a53rFWvgT8kgzicOqFDi/qCBRu2qYpaazKxfiF2iohpQRslr+zTpakvx
 PPnVnDWVA0xLfVm4QBjhYBf7AHqvuJGsdS9taFscusHZ+GIXuMSxL+LaTmYk1K/mCbrU
 Pong==
X-Gm-Message-State: AFuF++mqoauGZ+qENFAopkmGKLg6LujDsNw7+08+uiimdkOaaPar/Rlx
 09EKXNvp6KiXKrDYImxml5s84XoWmejm+CVjXIDhMY0I5How9XYCRwGB14z3G3f8pIlCudIkB4n
 E9ADDxxs5XbKj98k=
X-Gm-Gg: AR+sD132gpcIpbVEVKa20NtHiZAw9xtGwYiH9ODgo1Okv0EfplO66bdB8vc8L90M67R
 sSRIuMjqYMv2Q/cywZOJXO7bjrtMjmNmt3wBwVrEJXzuJNEDHQBD4IwVDYPW6mVlJ0ny/gsHwLI
 ooDBigUx2tgbGc6o6AVb8iE6JvI/xaS8yoYzk77m+0G0Y9PxUdCYGe/y35DrZ56v/uLQl8SweJv
 tUwqxryrEFiTFpTHqM0TmNwROuMJVw6iF6atUEO8QAIWv1Mmg3QUXnfXuFU+fZvfDK8ethn8c8H
 ngBXmHu+WH1AGa+sAOpwb0n3S3RQ4m4Kn1qf9J86+SLWqKa2Pmlcd30NYqPILAMnB/hkygdr0Tf
 FMj2Op2NHZq8aBoZt7UxQBTdWklNJjg+eshHbAh5kge7L2pMW1lgpKVr/lcneEsyWIc0cDTAn1c
 vtdZuGKgxkTGoC5uBdecQeJzlPvAOiwj4Qzc2ZlPXoEmO+JqGEvn7QCVkPKZicel5dR/cnYa8Pu
 8oIMKpJY7lKKOHTjDmZ3xU4RVID/tI2P/W7OkZm4WBPItFFeJRnZxPHbhbOlHtpshIPvajiZ4qs
 zAkQ+6jrYi/Wyh5uLBbvbDrw6taS2QOYVw==
X-Received: by 2002:a05:6830:3498:b0:7d7:fd71:f2d4 with SMTP id
 46e09a7af769-7f4aec76ecemr1430426a34.3.1787601181583; 
 Mon, 24 Aug 2026 12:53:01 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f48fc8623esm4975162a34.22.2026.08.24.12.53.00
 for <u-boot@lists.u-boot-project.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 12:53:01 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Subject: [PATCH v2 0/5] Fix logic of OF_OMIT_DTB and remove useless dts files
Date: Mon, 24 Aug 2026 13:48:44 -0600
Message-ID: <20260824195224.556419-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hey all,

This series depends on the series to correct the logic around
BLOBLIST_PASSAGE_MANDATORY and found at
https://lore.kernel.org/r/20260824194814.555634-1-trini@konsulko.com/

In this series we correct how we handle OF_OMIT_DTB so that we can in
turn not have an empty or fake dts file in the tree, when we are
building for the case where we would be omitting building the final part
of the dtb for use anyhow. With the changes in the previous series, we
can then correct the Kconfig logic around OF_OMIT_DTB and
DEFAULT_DEVICE_TREE so that when we're omitting the device tree binary
we don't try and build one anyhow. Finally, we can remove all of the
empty / fake device tree sources we have, or in some cases have but
never used.

Changes in v2:
- Split the previous series in two. No actual changes made.

-- 
Tom

