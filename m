Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE9FC4167D
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 14:52:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16FE0877D9;
	Tue, 12 Dec 2023 15:52:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=hitachienergy.com header.i=@hitachienergy.com header.b="J2ug+22I";
	dkim=pass (2048-bit key; unprotected) header.d=outbound.mailhop.org header.i=@outbound.mailhop.org header.b="YUd9Cdwc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2922A877D9; Tue, 12 Dec 2023 15:40:03 +0100 (CET)
Received: from out-ip0051.fra.mailhop.org (out-ip0051.fra.mailhop.org
 [18.193.30.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21E8B87754
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 15:40:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=hitachienergy.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=tomas.alvarez-vanoli@hitachienergy.com
ARC-Seal: i=1; a=rsa-sha256; t=1702392000; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=N55H/32RdaQQvlPK/y5CuLCYP+cx4zzg4TPNq+mktVgcYaoFn7cL06cLRCeKcusHtWhBhiDVeT77O
 1HIESJw9HjBOgJztFuio1xOoJ8UzRc/+IAd+63GQFnvWimZEeENH3q9fVSmJTHbOSo7GKjCUBJX4WE
 TY2zkk3t/FHgBKfPcCbDl5YXWmo5X8drYOvi49APclMkEErhO6KqCr2Di9KPwXLvgRuEYUPtWS4HM6
 PqP1qVRmMAQEKOBR7Tg1fXmsyQdXHYRy7OunYL7e/btGP/ooZSwMIpAI9bJxx8GtuGxtKYCvEvM65O
 6SKdUPuhDdmcToym58KxRcGcPUJierw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 dkim-signature:dkim-signature:from;
 bh=j7Se2DGdQhPlkj2ecrcXkCxxcxpZkQaS3vwJTH/BCQg=;
 b=Ssm/lwVAo2Hy13BO0jJfaHA0fEsvBjbM6Xlu7JkK3CPka/CkGOYmda11v0z9q0R8fXY617xKl7qB/
 Hwm2NU33ytzXHxT+4vbn52uK1hr645Jta34s43cKyiUpKcG3Ou0vNM60XyHnyxDhO9rKzqOp832Kcy
 YV77l4tnhx2jmXehhW8wf50x7dGVY5dswRNuuuIaM1ehEpFgBIeZzehLfmjLjs3y2HNzxQ7Ceh2eJ/
 2xRQ+/V/y0CSpu/Ihdn0QLnkQ5Lgpx8pB6XDZp9l6Efp2u3c4PhFKui3eAQ32L924M6EPhKrOcD40P
 3AFTWjyhDDpFoOFX5t5Dm8Q67vvHMsg==
ARC-Authentication-Results: i=1; outbound2.eu.mailhop.org;
 spf=fail smtp.mailfrom=hitachienergy.com smtp.remote-ip=20.241.147.239;
 dmarc=fail header.from=hitachienergy.com;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hitachienergy.com; s=duo-1630306886989-947ac67a;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 from; bh=j7Se2DGdQhPlkj2ecrcXkCxxcxpZkQaS3vwJTH/BCQg=;
 b=J2ug+22IyHk5+2/0SOhWGv2CXLMr1wxT+Z8GxIsEj2DZv3W8gZtsMhe1J7nqJpbV54SL7vmE+LbES
 swNtYvrMxoHtpHQICdgHLbJkZwOuMXHe6CBwqE5oOK5ZRxIFdbYTS3+lO5kc6TMdjba8zyBC77+YOc
 kZKVfAK8xaNrtuUE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 from; bh=j7Se2DGdQhPlkj2ecrcXkCxxcxpZkQaS3vwJTH/BCQg=;
 b=YUd9CdwcSSRnvXZexo5TPw4rwuHjkN3SmrJnHoqfL9jLw0f2kt5xcbgqkMbaR6kz0D5mp+DgXoig7
 3VouhC+4m6IkZCeFHbfqS6B73Q5GbkZ+p1RH4L9q7J+1PpdBQuklY+vi3kYxUFRVg04qyMhG2sBWdy
 n+2R7LbL/Y2oykw81EAgisVB9uBXXqODWwkNPeOb17CH8MiB0+hu1riLI5K4Ai5QIzUb3hAD7okHZK
 DPch5mX8DVMLv/lVMIvOmk9EAi0OCDUzasUsO5gMvW9NlbHs9ZQVb/JczSw2Yhez5D+Xqb4Yc2u2nn
 YssRDt6VsnqwpmxGe9WL2B9UOVmNgOQ==
X-Originating-IP: 20.241.147.239
X-MHO-RoutePath: aGVkY3NtdHAwMDQy
X-MHO-User: 514a5cfa-98fc-11ee-b0f6-9b9d9be6ef2c
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from HPG0000000534.corp.hitachi-powergrids.com (unknown
 [20.241.147.239]) by outbound2.eu.mailhop.org (Halon) with ESMTPSA
 id 514a5cfa-98fc-11ee-b0f6-9b9d9be6ef2c;
 Tue, 12 Dec 2023 14:39:56 +0000 (UTC)
Received: from gitsiv.hitachienergy.com (unknown [10.54.139.14])
 by HPG0000000534.corp.hitachi-powergrids.com (Postfix) with SMTP id
 2CF4E402402; Tue, 12 Dec 2023 14:39:54 +0000 (UTC)
Received: from chbrn3-p-dev026.keymile.net (chbrn3-p-dev026.keymile.net
 [172.31.41.203])
 by gitsiv.hitachienergy.com (Postfix) with ESMTP id 65D8C6854E9B;
 Tue, 12 Dec 2023 15:39:53 +0100 (CET)
From: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
To: u-boot@lists.denx.de
Cc: lusus@denx.de, trini@konsulko.com,
 Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>
Subject: [PATCH] board/keymile/kmcent2: fix update-nor indentation
Date: Tue, 12 Dec 2023 15:39:27 +0100
Message-Id: <20231212143927.1401784-1-tomas.alvarez-vanoli@hitachienergy.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 12 Dec 2023 15:52:12 +0100
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

variable was indented as part of the value of the previous variable.

Signed-off-by: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.c=
om>
Signed-off-by: Holger Brunck <holger.brunck@hitachienergy.com>
---
 board/keymile/kmcent2/kmcent2.env | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/keymile/kmcent2/kmcent2.env b/board/keymile/kmcent2/km=
cent2.env
index efa762e558..dc5508e315 100644
--- a/board/keymile/kmcent2/kmcent2.env
+++ b/board/keymile/kmcent2/kmcent2.env
@@ -21,7 +21,7 @@ update=3Dprotect off CONFIG_SYS_MONITOR_BASE +${filesiz=
e} &&
        erase CONFIG_SYS_MONITOR_BASE +${filesize} &&
        cp.b ${load_addr_r} CONFIG_SYS_MONITOR_BASE ${filesize} &&
        protect on CONFIG_SYS_MONITOR_BASE +${filesize}
-       update-nor=3Dprotect off CONFIG_SYS_FLASH_BASE +${filesize} &&
+update-nor=3Dprotect off CONFIG_SYS_FLASH_BASE +${filesize} &&
        erase CONFIG_SYS_FLASH_BASE +${filesize} &&
        cp.b ${load_addr_r} CONFIG_SYS_FLASH_BASE ${filesize} &&
        protect on CONFIG_SYS_MONITOR_BASE +CONFIG_SYS_MONITOR_LEN
--=20
2.39.3

