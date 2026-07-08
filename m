Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B62C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 01:30:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 350E3849F0;
	Wed,  8 Jul 2026 03:30:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ogDrGBQz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC399849D2; Wed,  8 Jul 2026 03:30:26 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AABBB84118
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 03:30:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7e9d7464b71so60839a34.0
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 18:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783474223; x=1784079023; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=3Qu+DDRLdX77BdntTGnKnpVOmSBaxeqxGTPGx6GYmPc=;
 b=ogDrGBQzrnmZgxwqDQASnPilKog3AHEmy2+aKAEjSpszSdQ9XJg8lcL8sU0leWGSn/
 NJISPDetkoqWa0GtPq5LnSEvK8bb85uEAyDsAnI+VrtGLFg48idP4MacAH2rryecsaQ+
 9lYJwnCkggnb834S5Cp74U5WKuQMVgD6Rhd1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783474223; x=1784079023;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3Qu+DDRLdX77BdntTGnKnpVOmSBaxeqxGTPGx6GYmPc=;
 b=guUmjwY+/Q4YHOIKEKpXXJP57v+GfTp7/f5Xm3F6p62SgysWR5s5aUGVK204JCuJUA
 NmPanMvvr1jG+cW5uWcoZ2h/BUJ6kdYpUl17iEIXZ05xfRTzeAmIT/yoh2nEKaLDreSf
 TAImmiRfHZU8BEKZAXZbDO+vcMe5t2MZUmtOnf0kTgmDvZ/N+BFzw0rLe3NaRLcEUCpx
 /nUpQaKmBWMoBPKe56QrzkGt06+H6hYPmL763XzkM6yYncwliD5f7coHxYi8GFoggXz8
 QB0tBg8L2BWxoHzZasJCEyGGi0+GsC+z5ASa5VT2YYUmfCeeofoMflZjzxnoDK8HExhu
 KZ0A==
X-Gm-Message-State: AOJu0YzsUHj7zX0remO3hTUKikwOHMKNwMVix0TpYbnGdrCCbCmlWg0l
 dCOXhK3YoxKDjC5dxku1CAtpR2+iuCaVtNC3OyblA7FyzDljgZEiJzHsN2oVND2ZCJFTp1liPtp
 nb5nWLmg=
X-Gm-Gg: AfdE7cnEfZbQikNVatN+3Xpjbl4LTNnUWRadu9DGfkEs+WTOXkZ+3LN3inXIn7keBhv
 WLxFAbh7gyxmf2tgFuH2mKG7sGyGD/a0cjZ3BKrhIDoLf0rXK1irBIjsT8dPzJpHN5Wyiu8fbes
 www3N3ry977n90TZN9y076HksdiLCsM2tAnQ3ySDP82e/ZEPUqwqJVFVt6MUairM318ayCcZ1GD
 EH4olSxGMqtQcxsA4c0gsg2qMLnKBHE/xvzqG0IrxYdlgEdSGq5jBdgEchPxQaQkVwY3FjtlYj8
 Fh5UIkTI1q3aq2wXIegeup1f50ZRJC0NxA8tOd6tLDOq+fO9+JRW0OqkzyS3Ue9odXskIzHpqx2
 L1uH0luAimSDSgLu4+0JffISgL/DM5hQWtXeGEUIv63Nb2+Q2n5OEyfcQ0JEwXdHJXzRDbuo0E3
 h/u+6D9tojO5f+C+eZ8z8z6uYQKpa1vi6dBJJq0NsUSnVoG+i5FThCSF4NQKrf4dchs6f1rBDiA
 LIpljsC2PtTljj4oF0gGe0q2TrEdo/gdcYcrtzSTCiivaxT7oKbkNppxlpzGw==
X-Received: by 2002:a05:6820:198b:b0:6a1:50f0:ccd3 with SMTP id
 006d021491bc7-6a36dad2e48mr294427eaf.72.1783474223346; 
 Tue, 07 Jul 2026 18:30:23 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ebcaf77ba4sm780182a34.9.2026.07.07.18.30.22
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 18:30:22 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 0/7] Correct behavior of OF_OMIT_DTB
Date: Tue,  7 Jul 2026 19:25:10 -0600
Message-ID: <20260708013019.288985-1-trini@konsulko.com>
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

I've had this series kicking around locally since January, and I'm
finally posting it now.

This series corrects how we handle OF_OMIT_DTB so that we can in turn
not have an empty or fake dts file in the tree, when we are building for
the case where we would be omitting building the final part of the dtb
for use anyhow. This ends up taking a few steps. The first of which is
that when we have mandatory passage enabled, we don't allow the fdt
address to still be overriden. This goes along with reworking how the
vexpress64 and mandatory passage support works. The overall effect here
is the same, but the logic around it is now clearer. With these changes
done, we can then correct the Kconfig logic around OF_OMIT_DTB and
DEFAULT_DEVICE_TREE so that when we're omitting the device tree binary
we don't try and build one anyhow. Finally, we can remove all of the
empty / fake device tree sources we have, or in some cases have but
never used.

-- 
Tom

