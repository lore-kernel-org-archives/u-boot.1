Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69316CC6B2A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 14:48:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 24E8260834;
	Wed, 14 Oct 2026 14:48:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VK_WT2dKNiAm; Wed, 14 Oct 2026 14:48:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7CD3A60819
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791989281;
	b=Pp+bFbKQTeTd7HJ1UXozPXrn/ZapLvhffolrYByPvRKFuSgHSOAK6rtZu2NIjD/ov6cj
	 UNcggE+q0HXCfdqbOsMwp9or2yydqA2jHYuXSFUAtEhxgo83EMpqQlRaMuhZt/5jEI0Gc
	 ZLFnRs8Xzk66O/ARh3PsBDoRyj+MCVNi6wLr1p+W8dkSkQBCPtY5dIi9pXKj6wCjfOgPD
	 3la486nR/V33njbfY4GxVD+7hZEEuMfCkXSZHvS/LeVggpZsRo2YUaQC5c4GKUoL4aJj3
	 gjjZ9fTDIr9EvlCTZTdvGmNZ7nTFu2parCT/pwZWGWClxaJnR7k1EavbwfAfwxzalKA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791989281;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=e74eCu7N8cXkGVmaJe4hpkJPtEM5WJl1u6X206MBBqk=;
	b=RTmPoNYovUMquWApqv6KS3oHQri6+jn27RsiZeD6XZ/+j4AWrPI7UsD07XvCUXfxSyPA
	 cFE66y65crl/ONsb4lOFrt3O1TOQ2PAPdenSr9OWfu/N47BZaZXXwz7lwoCewnRYijO0m
	 pIuaQeyGxmlVBbH1BfxGjz3Aymw7wLnQnLPphwuANaD5uN7KnKFNbT6EPOzicGdkVK8Gu
	 YldW8oOKubsO/SPSRI3/Gin9HC3ei1ZErIybfjyleZnhEhEprRuxhFGqrHthqH8d61o/N
	 9LpdgITTd1aCjjUt6bbDienTYcAjK1CifqfSe/ZxE2Is7fQtvvUga7xFC5uUcktAv1A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791989281;
	bh=e74eCu7N8cXkGVmaJe4hpkJPtEM5WJl1u6X206MBBqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D6Z/3oZCAM6kDGYQoMhNMWElS6BOcijJYtfNtAd45dMnrjC4U7fNqMEwyGYD5qYLQ
	 8ZCIni/hk5/G9yAVu/1R0G7vKDQI3ju3BDyVJyIT3eD0SdlcS/WHgW4fM9mzMglhLM
	 zQCyEsXy0eK5mDnnHRLQAHOlaQjHqUFbEJDBP3KHEuIBQB7O1ynqsAl628mD+d2hES
	 1av4s+whkH2L2svwtn4GF4kBXtXnFbCk+ommgkkxmc3y7wdiRUxGCF57XeUy0Nj3Lb
	 CEIQhsiIm+SJaXiuDWEOK1q15BC4t6TlflCcLSNOvsDmQAxzedXlcOi0UKeuZ/D97a
	 Z1wqvnwJ4aaJg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7CD3A60819;
	Wed, 14 Oct 2026 14:48:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 51F33255
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:48:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4348F4019A
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:48:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UKlPI0_LkDh8 for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 14:47:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A48EC40189
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1230"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791989279;
 b=jF6ATTd7pxRhs058WbpKoaTuyxtnmlyFq4n1TnGU7DjgZZ88tpDIzrSou6YSmRV6gp6e
 nRiX4zJHviVW26uLvgwbGi09JNlMId7Ubczjha0nUmbnNSPS7ur0lA/KGsl31sq2CowDn
 qhXLaGxzy3bZ0HQqM3udeCM42+T7ciaDihLduVbWDvcWFpwj6PAGXyzQR7+CAgGE9FgvG
 QITZQrsAtJBC2WickkEhiXSptrMBdBe7VNAFrLonJQ0F8hSH8JzcA9J1ddiFOUE+dZYzB
 idSdTl3LcuNfxLZ60HFjLVqp9GpDKby6/vr2q6Jde7MaMXeK2LgLD/6+MY0weG25Few==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791989279;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=e74eCu7N8cXkGVmaJe4hpkJPtEM5WJl1u6X206MBBqk=;
 b=PX2OMxkax0QAolnLyrF2XdkklrWdGvvkkZS1v6NQqzSDgiV+Cm4x+o4j+UncGcJ8wd+m
 9Di45Jxx8+3tfyha8nUnhvWy0qPgObGbyN/nwycbMao3e1HWyvWr7RfY+3c1FY0uBdwCi
 eGnNjXQphf7x+vziNoPl/0fzvIypbgcgpRA8/HNxMEhvREdm5U4l/yqciKq4bHJcoHBo5
 +TcOeQocxxDWnSIFYiRHMEbHQQZr3QW3TgIV1dKEZK18+3BzbXTf5hO0NEFi1X5sbFGoH
 rSQzuwtLSRkUZFMR4HN4Dw7HZC/82jK89GzkvcW4tHauUMPfjFUhrwvTRsHsgKxIHvA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=bzdXXxzG; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1230"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1230; helo=mail-dl1-x1230.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=bzdXXxzG
Received: from mail-dl1-x1230.google.com (mail-dl1-x1230.google.com
 [IPv6:2607:f8b0:4864:20::1230])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A48EC40189
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:47:59 +0000 (UTC)
Received: by mail-dl1-x1230.google.com with SMTP id
 a92af1059eb24-17bc533fda3so1076029c88.1
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 07:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791989278; x=1792594078;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=e74eCu7N8cXkGVmaJe4hpkJPtEM5WJl1u6X206MBBqk=;
 b=bzdXXxzGwIAmHl7SH85QbY+qBq4OzJ9DpQp1aczjuj0++Jasl5sMRSu6n1QqeH4wgv
 N5BG0ve3RkDYqk+/+r9CmNzQuTLJK++CtnKZySixHkOO+JfBEX2uvmPs9PmJlZvtSKOB
 OCIiPDMxLtBSQYlriK1qMv8o8XmNMqPxDNXU8KGmZg+CkFN3krL8t3FBDf52OV6R5PFn
 j5Z8WnoBVF02m2u276rlJLNjeb8RUQhPtodaMtmYpmi0p4thPi05IArYGCZdd3U2nqxB
 AbymH5Yz3Tlezrq7iqCCR+cK2VwGBJ/V+7IjqvPSeKOxQpdZ0S9K8xNfJJ/a7LjU1q3j
 DEKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791989278; x=1792594078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=e74eCu7N8cXkGVmaJe4hpkJPtEM5WJl1u6X206MBBqk=;
 b=EyTsvK6OCHn55Uy39ONH6D2WzMW360woqrtJ7L138Bfz7sBWKzejZr+DiIKdGiti6k
 gl+qlUyoVKoHgTG12TQFodiCE/uSxWtX7zjDgRCnOhTKfR59hk3TTvbc6VU/gW2SM4A+
 iPgt4LYHrCiNCDT3rTY7Ph0jFFh1VJ4N+2Tck6HryLwRcNaLN3+iaIrLRhYa35c9R+FF
 OMNtEt/aMzXElDGBEuDSnFVhdcglyfs1LyQI/Lipmbw9I+t2ZZw6CSxYZ3igWaYr3NuB
 0EykbbU1SM7vJTSPIsoZ1UhFHdeZ3xgaMW+YGIc8Gy81UGysS3Fc8TWVI7qx4BE1jVZL
 M8Bg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxjxZT/au/sNRJDv1QXdNe2ESG8usjJCc5EHdACHjfwm1l6E5mOHYZ1x/4a54cypvF/LfJmIjg=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIUULDPFgk/OXnnXczVwi3Qe9/0h7MYfFZikHPXWc238911UVzs
 wkivC/aS35nokcjRWjQuGwZ2cNF8JH4M3KAgMj8Doag0ARgtEBwrg/Tw
X-Gm-Gg: AYBFou0X3dbia9hfe5N0Dw+SQiFVmTLRELq93hK+NjV8GwQajG0Jiri2w7bcNy3fe10
 DjfJ7UjZHBrlyo+qOqMC83j9tuux8KSfcQYuLH4Nvbw5d8yg3zSsW2StUXoP3FZpFmZEFZ7/d/3
 2Izt8Db7WlvPL/RxPPgZTintFU46wPv4bmyIvn4OeoDYj0WtgxrUkOi6G8kF+Kg8eRWF3d6pKOk
 ptddaaZf9Be5VUURUZJS9pQQDGOTgh0r6f03Y56+vprR6wyn5WRm0IchDom7YnXjkWo1Yd21Efi
 DUxHgDTX9YgglyuhnNLSByknvEL9eoAS3uPIHwVptTw966uR+2ZdoAqJuQOWnkdcWtTnNXcTQE1
 FpkFMKLSXmWivfTrUuyXmqYjHwHbR/mjQ7Udu/LbNalaIDow13Eo8OGiHLtYzuWw5jadA1YVlcY
 1p3AIJYByC4nihat2SNwjFiLACf+w+MTl5emriP+eUr9W3xPeHIgDHZ1io1Kfa+lZspxYXLg5q7
 qlwzNaDeOd7YSyrLAQ4bwWiejstV/sqzNbiJ1QTeCs8vEBYm8g0BHa5tkqStWOnMgKcKu9+Xus6
 OLWOs+lF34bKBaiZqwQv8KCOaQzujz1lt5jihFhKaokGgrNisBOuDA==
X-Received: by 2002:a05:701b:2806:b0:137:5b9d:cf87 with SMTP id
 a92af1059eb24-16a4e6cb97cmr23905260c88.0.1791989278109; 
 Wed, 14 Oct 2026 07:47:58 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a2d2db98sm44840639c88.10.2026.10.14.07.47.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 07:47:57 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>,
	Tom Rini <trini@konsulko.com>
Cc: Leo Liang <leo.liang@sifive.com>, Tim Ouyang <tim609@andestech.com>,
 Yao Zi <me@ziyao.cc>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.u-boot-project.org
Subject: [PATCH 4/4] doc: qemu-riscv: Describe booting a kernel through fw_cfg
Date: Wed, 14 Oct 2026 22:47:24 +0800
Message-ID: <20261014144724.1763675-5-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014144724.1763675-1-alan.tseng.cs@gmail.com>
References: <20261014144724.1763675-1-alan.tseng.cs@gmail.com>
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

Explain that QEMU passes -kernel, -initrd and -append through fw_cfg
when U-Boot runs from flash, and that the qfw boot method boots them.

Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
---
 doc/board/emulation/qemu-riscv.rst | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/doc/board/emulation/qemu-riscv.rst b/doc/board/emulation/qemu-riscv.rst
index 229a7700a..a76a1a8bf 100644
--- a/doc/board/emulation/qemu-riscv.rst
+++ b/doc/board/emulation/qemu-riscv.rst
@@ -205,6 +205,18 @@ Invoke QEMU with:
     qemu-system-riscv64 -M virt -nographic \
     -drive if=pflash,format=raw,unit=0,file=u-boot.bin,readonly=off
 
+When U-Boot runs from flash, QEMU passes the files given with ``-kernel``,
+``-initrd`` and ``-append`` to it through the fw_cfg interface instead of
+loading the kernel itself. The QEMU firmware boot method (see
+:doc:`../../develop/bootstd/qfw`) picks them up, and since ``qfw`` comes
+first in ``boot_targets``, the kernel is booted without further input:
+
+.. code-block:: bash
+
+    qemu-system-riscv64 -M virt -nographic -m 1G \
+    -drive if=pflash,format=raw,unit=0,file=u-boot.bin,readonly=on \
+    -kernel Image -initrd initrd.gz -append "console=ttyS0"
+
 Debug UART
 ----------
 
-- 
2.43.0

