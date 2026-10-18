Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 301DACCF2C9
	for <u-boot@archiver.kernel.org>; Sun, 18 Oct 2026 15:59:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 772DC80C7B;
	Sun, 18 Oct 2026 15:59:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3IoUrTTE0tHm; Sun, 18 Oct 2026 15:59:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C93B080C16
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792339154;
	b=eAEQPIioOw1yuD9yMZYMaNSnJ0El4iF9Jtjo46d8/QcR4Q0Q3OBjqv0QyxnP49OnfN1Y
	 Lg2PZudp9dAb19CbewrpGXqW2rVA11SPQq2eQi4un+SogUaz6EDu0SXXYv24647sBp1KV
	 tPAXjHsdFum2ovq7LD+pdxQXpM1LXaB3n2L9augoKY7cleIStyFkO+wkX4Cll20xXrneZ
	 PQaMkGCsanU/u9Md0dxntPEjyvESsDdPuWhGCEk3tIPzFZOExtH+dyaN4Eb1LoDY+oOZt
	 lWUXEiblOBG8rqKPLhl5KBuevJS4qwXBDNmlasfP0WLwdHGFvDvkXka8WNbpMuSbHZQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792339154;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Sender:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=bY0hEi+/8nxJwDz8jSm+EE4JO9jflgSjOKIaJ5gTjmI=;
	b=OMLyG+A90vi/fmD0dE2Ndmlev/WEWwRcf5WkeJ/K+5Pp59uhszRCBdcDgk4skVGTUDuL
	 uhaMueBEknBd1oRVgdoE5AGPj9TLd6IDlDTWU0d9NVdT0xN6up7OtX1cYtEQ86NFtK1uI
	 SE0JDYsxebZp8ubt56ia+AjJbv0qVnSG+CmBPPX2Oyo68FskHXuZIGzp9BKuvcPzsqtDe
	 Sexx0UlQ68n7x4R5HXskTRN8tvJoBlQLghZEM5xhQczPJeaoUl8wUkd+cLu36gXnG7bEw
	 +aNJIShK63/A1R4GQH3ysJS2KplSBq8MLrBGZZCwlgRjngKCR08TK0VQdXe3VXVTVIw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792339153;
	bh=bY0hEi+/8nxJwDz8jSm+EE4JO9jflgSjOKIaJ5gTjmI=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vvRhOsB6ZiInvOm5mj/jjSOieEtemX6eeb18R+ExVQDbi4dgqVrJ2/dJ+dr1bbUzZ
	 Igv+GHGlaQcIqzLcPOlCMLtugDmyPRtHlnk2Oeyc1HVpRmIkXA68hXDnrgFG4brMX7
	 EMxPyb/XqMSEAQR95Brs9TMVGKln6yBFtTGx7WH9jyyH7wz97S+j4NIp+Vgr0PN1UO
	 6uMcgEh4jjZudGDFZg9TTVR36M6g2+7+KtqcRvoBHk+tclM1xEAJMs+n4BQ9X4ZqEu
	 YT0hUSLM3Ms5co59iucsb7Zy83sa8DywGFOAltXZ7rJBntUjT9mT9GxK++seUWsSdV
	 wkZiDsnJtAupg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C93B080C16;
	Sun, 18 Oct 2026 15:59:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6249961
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 15:59:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 540D6605FD
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 15:59:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2zTlexYw1iR1 for <u-boot@lists.u-boot-project.org>;
 Sun, 18 Oct 2026 15:59:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 53BA3605EC
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792339151;
 b=fISeGP8yVyaUDZMp2aJSdAFJfgnN3ve31ZiVSROIQO430YlVlJ33effneiChFwXMhp4J
 ceiQrrmuR/BJPdeGfveX48uTziFCU+AuaALT0p/mXcjNzJ4Bd2KRzoH0+8N0pZ34sO8zW
 QduyplSEQ3YYBWpyhy7gDv68rcGFf6HfK7utsJ+lMWcBLQavp8oh6XfF8hcrJ20k8Pnf6
 aoqzFf7aV6x+ayw+4i8WTnvRjWS7Q0XJ81aGdNsTuswuziP1TC8a4R967LPp6txArzhhj
 XVa/kRx3lOu4cuMQ8q5o2Y8MlV4o9x3aDiPWs3iKy5V91bghRqzhvaudKZBfJekniPw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792339151;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:Subject:
 Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=bY0hEi+/8nxJwDz8jSm+EE4JO9jflgSjOKIaJ5gTjmI=;
 b=mQUZRotElkxiJcjWMWCDgqWjXNfRdCTst5dKPWHdR8ijZ+S7AxgZYJJ0reDAfSlMQ0Sh
 zPrZ2Y48rspzqZ1/PnceDxqRABLbwAoqaODDBjbHR7YIpgog+vQ2EeQdLZ83S9/L0049Y
 GGTSwz+KhKfKI+qaqR52F2lG+odcVhTbl1TdW7Oiv16YFwoPYVMrkNL9lbSc6iPKzdmRz
 5LQ5ofkq/7fL49DW5yPQSk3t6zUAUNli4ykq1pur0VOG4B+ZnZljPZkbWp6O6cjnTq2nj
 2JfSCPgFFcOSTBSllhfFrRNCa7MMtoJ9so7D7zbfsSdcoOT28BBbz7efL5HKN7dplDA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=CkVTL+yO; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com;
 envelope-from=massimo.pegorer+oss@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=CkVTL+yO
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 53BA3605EC
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 15:59:10 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a1cef0439aso14283535e9.0
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 08:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792339149; x=1792943949;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bY0hEi+/8nxJwDz8jSm+EE4JO9jflgSjOKIaJ5gTjmI=;
 b=CkVTL+yOssaF4T67nqOCe7bH0S3dQsaGKEBMCGjlWoyokgWTNt5RFiaS6+GZ0TEFxu
 3KS8rtipjMBdniW0+rd5jX6QGUHX2BfUsxAL0RGpKKXIFkt/so27stsbs6ac11/Fhn1A
 Z05w5+fJR6vtcDz9kz7WTShG/kIYgYfA6/y/8tPUTSELhfKOfmsEzS21TdlXDOklM+5i
 s26dC5rOKx4RGYv5JPF5XHSuF19p8/0RXV14lN4fHIeUnVi7OBnZlyNlmKV8X+KoOohO
 WWZgqzp1vnPDPdRaFB8xLGtAA8GVnYu5hBBAigD04Jp4wr58FFQ+dF8Iuj67ingj8xFr
 XEbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792339149; x=1792943949;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:sender:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bY0hEi+/8nxJwDz8jSm+EE4JO9jflgSjOKIaJ5gTjmI=;
 b=aseaTgnbVzx3yfoABQW1bZIgQCW19IugG6NlzkSP2hp4kMSxrPW07MX6GVMwKME+AY
 0/LjSHLjhSs/gFn3lm6QgFu/Lg/p0FCfKmBHwVOZD+9ezEYXsev/cR1N3E9QfxT4v4Hi
 HJQakvJiK+W/g2OipFqBdeKUmkwcjWy1G1p0XfY9iXXzeDh/CKkvwvBIVALB57ENJ+3i
 wG2lkGtOaS9ekVB5GA1PR7mmLcxtOdtXGDKVdhzyXTlOrIsHh6WPG93j/ed4+8sTUUc8
 MTwAq9aaeca9WXIqP1Kj+3mED8iuzAWdlnrzlzhosSleYvXQiqAAdrGO3BkXWtpr4RxN
 2sYw==
X-Gm-Message-State: AFq9FYK7vOw5I8BvZz7MZqkrxT0F87BjrIJkO/iivd7sOvAGGxHGhQnd
 fJzwe3GdRufow5XBbeENIosJWslC8aIKegetnYueM4Ndrc5g2efM+RtAq5JylQ==
X-Gm-Gg: AYBFou2SfFG9yuguGGz6trr3wJNHXQYwnZ+tEZrI8JrtZnkodWUqCWYWGSSYwSmHbfL
 j7mlX1c85lPxapeEHFECEn9qa4jidMxrkrU37XDHJbTvH8ksriBmyiNLpA307rkl8J4fke9oBKb
 Uh5xEOGhrx5isoh0nEOWFAY73YBCM/F5ZTdM9cFQeecMxwduHTtRykXIzdZoE8nxmL7+aYX17Tw
 6ezfRkCKU3rbMpz+9P5em8wqkoPsupZ/EbodjX+0OimIcF+CB6W32IeiqMJVUFzOzmbRFAqmg0Y
 w4e2/iTtWivrdnwYl4wq+Isvjpw6nLripSUGJFc53+bZJW4SzPyOda8gl43QyOseyRXhZaeXhLq
 R50rMNDH7mIY89e/+FjEGpNwvqH22kufKaoOGN3bX0k7OppvjktxvKdaUFfFO5iEpI7zCjrbNfd
 z6ek80Tp1MqkywZsfqu8vShYfE33cx3RTX1bT9LTa5jdbQ5hT5CCaqNpEI/snJQnlqwFyFyp6N5
 AncFBdk
X-Received: by 2002:a05:600c:3b13:b0:4a0:2150:55fb with SMTP id
 5b1f17b1804b1-4a1d75ad08amr133475055e9.4.1792339148530; 
 Sun, 18 Oct 2026 08:59:08 -0700 (PDT)
Received: from [127.0.1.1] ([151.71.143.36]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd503d78sm17053434f8f.50.2026.10.18.08.59.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 08:59:08 -0700 (PDT)
Sender: Massimo Pegorer <massimo.pegorer@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Subject: [PATCH 0/2] Update branch and URL references in the documentation
Date: Sun, 18 Oct 2026 17:59:03 +0200
Message-Id: <20261018-master-main-v1-0-e07455d232bd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMfs1GoC/yXMQQ5AMBCF4avIrDVpK0FcRSxGDUaipINIxN0Vq
 5dv8f4LhAKTQJVcEOhg4cVHmDQBN6IfSHEXDVbb3GhTqhlloxCHvWo1okNd5FlhIT7WQD2fX61
 ufsveTuS2NwH3/QCsyNggbwAAAA==
X-Change-ID: 20261018-master-main-b0aaca076372
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Kever Yang <kever.yang@rock-chips.com>, Quentin Schulz <u-boot@0leil.net>, 
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>
X-Mailer: b4 0.15.2
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

Replace master with main as name of the primary branch.
Replace previous U-Boot git repo URL at DENX with current one.

Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
Massimo Pegorer (2):
      doc: Replace master with main as primary branch name
      global: Update references to U-Boot git repo URL

 board/rockchip/evb_rk3229/README |  2 +-
 doc/CONTRIBUTE.rst               |  6 +++---
 doc/develop/sending_patches.rst  | 12 ++++++------
 tools/buildman/buildman.rst      | 10 +++++-----
 4 files changed, 15 insertions(+), 15 deletions(-)
---
base-commit: 8d534cec0cc0109a37c0ded8854da03f1526dc0e
change-id: 20261018-master-main-b0aaca076372

Best regards,
--  
Massimo Pegorer <massimo.pegorer+oss@gmail.com>

