Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77438CA5FD4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 12:26:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4676440DBA;
	Fri,  2 Oct 2026 12:26:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XcVcQzHQPnYM; Fri,  2 Oct 2026 12:26:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2FA7D40D8A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790943987;
	b=fjR1VIqTDwj8uf0hz+WNX7al2Ea9FJWI6Mhm/+lvikvgHVZDsQadadJZEVUV6YkvEPRk
	 OFKCMcMfYKfq320bV400PJnEhQFLAx/DFWiPlxl1BQkwjGb31agf0/0WQJeHi+UbBHve8
	 h/bU4m4fxGBBBRoRDACaVf62qs76EdJ37P0fXw1LEiIZol4v4vhqkrHYqtKenSZURYHze
	 DyDhzunnmOc2iQE5fcCwbeQH6rxi8z1QN+sbDPG16uYwbm+/A6qM0OKFxAUtzMTESliR4
	 jt0Oqp4laHCm+Hifkc0trMlOhvi0fEACc6cWbE9c5EQIrXdO4xHIqq47kxw6zxyysQA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790943987;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=x4NRx3tbg6ZqZcELm5FPwLs9/cpyYeH4CZ6MnH9rjyA=;
	b=GVEKcmJ7PfEQQmL8kH24k8NhJru+3WdO/abyTO2duK4wK7Rn9q9xA1JeDofbYInx6Og6
	 fRkdtaG1bdGgIBRfouIeTKeb70FeOQUewAgOFEFjqKMqdVPvFfaPETnqIeXjQ8sOeNYps
	 o2bLfxN4W6aYl4dKeQYqiSjr3qYe7LWqvboPlNpJKcehq4mFSbC5s/LgMYUHui05V6Ved
	 Uw+7lvS7/1SCjVOtSexyZTNow39xhcxiFE+YZEztcrPpUxPDmdA5kLSUPM5JaRz9NRzjZ
	 2LAwgULn60IVbclm8MOcgA3YOiPfA3Eozhwhjr2rds4VKu/U4BPzcJqc0rIgP0BF+jA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790943987;
	bh=x4NRx3tbg6ZqZcELm5FPwLs9/cpyYeH4CZ6MnH9rjyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=riUUVj4MeQnJfKl0IzbaIuDI3XDWKgsH9tAQRpGkcBDuWFcC16fONOIQuqaOtDt8d
	 0j6qjvnN6qjB1zydUh2oWkr2Lz090iZBFZwoR/chqRTlVrESPp3hA8iPcfcBEcv6B6
	 ghl7CfderJT7OR1tzwnR8OmLevEz8fVmcBCE+N5v3sivqw/lnJNfr21mmfwCynQYMD
	 /DE2Wembz727aTRx7RCd5eb7ZGXgglET4MVT71umzPxN1qY08w1IKWoLfXIfy3sC50
	 b5TLL3z7RMSr+ZG8z1fV3uzVbmm/g9gf9AslkIdFFwav8MhLyIQpgomU1HuHr/kMEt
	 Fs8bM5dNYV+HQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2FA7D40D8A;
	Fri,  2 Oct 2026 12:26:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id DACB4282
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 04:47:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CC3CC607F2
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 04:47:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3TcW7vKPcUuF for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 04:47:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0DCA3607DB
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:39::c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790916424;
 b=AS6HCuYisRjyYksMfBmas/fQNX7QWlnnFwOWNi+kMe/ivZcH0AXOfmKo+3DZcozkoA9U
 3a5Ys9qS1mADLRntZJmBr0/7zlLZCFyux+0uF3rEBc2vd7Y6keZg9cKD0Eq1q0TCSFuh2
 HudqTMOwjFnJBUL8xlob66bqwz8JTe3wpDuTEQRTXQli2qffBDrSnIlR8QkYls2qYNTtr
 DOPMyWinXAxNXk7E9r1Ms2b8X0wdqf02SEB2XZneAXmXek+5vQQIxP+WLSmNmIsVfDq/j
 oI+3SVoyWBLuZF18rSf5yECyeDb5z2c/WlnjrGnJkMmRtKUgzppqhUclLphsWT3LYjw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790916424;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:X-Mailer:X-Developer-Signature:X-Developer-Key:
 Content-Transfer-Encoding;
 bh=x4NRx3tbg6ZqZcELm5FPwLs9/cpyYeH4CZ6MnH9rjyA=;
 b=T5bJBsh7FbcEbsfnk8EXKyiQVh1c9uVOi8Ru7DLkivhiJ6SVJvs5btNMwi0kLTeDEW72
 1iRN730iKRP5aTpYk4IcpR0hf2+LGcfkPqIzLo/icG3NVisb2iRt1ceJujYuNtr/gg9+c
 YHcuFUBo+7Rauhr9kBUAzRFgc27QpzKyhvzrqnRVDkYOEC0WRjD+uDytpQnNTMZSS492I
 fwnAnWM+QrvSv4mstr8V6JLI+q6vLlz6eWe02SLyHfDi2JaKMt6ETtz3nzV9FvNzTDwA+
 f/jgExnDh4UvSa+KUZOfCi7cdXOqaYhSdMj555Lxq/rlLl5etNCl5wmbh+XZQEhyaPQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=J+8tpoHg; 
 arc=none smtp.remote-ip="2607:f8b0:4864:39::c"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:39::c;
 helo=mail-pj2-x0c.google.com; envelope-from=sycamoremoon376@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=J+8tpoHg
Received: from mail-pj2-x0c.google.com (mail-pj2-x0c.google.com
 [IPv6:2607:f8b0:4864:39::c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0DCA3607DB
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 04:47:03 +0000 (UTC)
Received: by mail-pj2-x0c.google.com with SMTP id
 d9443c01a7336-2e494adf48dso4852255ad.0
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 21:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790916423; x=1791521223;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=x4NRx3tbg6ZqZcELm5FPwLs9/cpyYeH4CZ6MnH9rjyA=;
 b=J+8tpoHgEwX9qi8wq7T9TB+1R7x5PpowDefjviU6pYqO2g72BvU5pO2Vcw5g4UEzEr
 dKoqCC/EYzXPS+DV7aBN3elH/+lTUisSQYrUztq57cOHhHk8rLW126hLAqhilEUy6x7C
 ARxuQsDPr0MQMiH5s1/yDfX951rjed35q4+CL/YovPS2zoECF9JBTElTieb6uQ5vhu/B
 6bc6cEXdu99+uMU5ESMoxXTOF9ZVy9iscS1SI5hSQrrxa6UGhW1M7InmS4n+DGRtJN3m
 MlPe5oM8489pCoItoPC4eGaIuiuUrtWmB8sb3ZTqMqT5GyXrjrqRiDheAgmNyYyws5Ph
 N3IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790916423; x=1791521223;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=x4NRx3tbg6ZqZcELm5FPwLs9/cpyYeH4CZ6MnH9rjyA=;
 b=Qc/pgmfS8vJ2Zjjx8t8htG8g4OsEdxK3QLbqSVW/FXecZoGepaVd1sLHzJ+hNFoRdB
 MjkT/NVvW5+SFry9idAuL0MecK+YECUZCu7oIBTpG27bRpEMhYevL19xzDTo5R7W/3Bl
 8t7m9VPcInEx6rAt22GZC/IlgaX3HCojm71QfYh2s6y7gDuUUKhgzn26vOXFAEIJl1Lk
 rN+XtEyIfGCOpFeCo8GieBTS3xPruKt1D02x7fK87JStYIIxb3BeFk21P2BWiRyhRnXC
 Ia0AihYUOJQkJffGi5p4CKnXG5IO1WmxorlCnQYby5w/PxGLO93aXGpH9WgszQCRCFUL
 5bmg==
X-Gm-Message-State: AFq9FYKmtnG2lMwNNydP0zmoE1jztQHdPX8BEapZNkalyxkc14SlH8mv
 34x+XfVgQ+vmENPZaNzmM+x6DcLGnGsGoc99cRXMu6tvJN7nAl+/70rEW4siYCMnqxI=
X-Gm-Gg: AYBFou1srGRR6dClLIO9q7/QR50Ztgxs2NqLfzwhIR6IYxwIzyPpub6ImwXLd8Ee2Gc
 BmuVmMHYJrYFaWNFjulLOReCJTAjTdTyk1oCVBXtEErKpPbApm3jRwbrXrmsRiu4V1WOn4qMaBP
 02YpTRtEK6mLYiqPH3gitEtBi9EE2AkRKJWNfDQuuU1tZZIZnDVPqI/JxDwqytytLdaq+A3/hUV
 AKiCaz55jhA+iXffpdxexjKvkktcXdyKM6oZNWgXwP0ABRXq9+vNdklhivuygEKP9vseXSqU+P6
 SDlX7XaQRa6X9CfrhXLiE7Fj7pvlxOeimDJhmgSTEc0wY9dNqy4NC14iGYfoCJFlmaeYVi+7uM/
 P6oV64UEHEI8u7uP7k2hnkJqzrOO7E6wKbRcDDIbp8dL33Lb49GFV35JAuyV3PMQD+w8Ew3plKA
 Pm9IrQYvxCAX6cXz/FGhdFtKvjvftKORbnwABI4AcRfn+gcOq1lJhlqy0uuizvP/HS+PeVDaMg9
 RqHJFb1Fw==
X-Received: by 2002:a17:902:d502:b0:2e2:ffcb:87a9 with SMTP id
 d9443c01a7336-2e49b4e3702mr15346225ad.24.1790916422846; 
 Thu, 01 Oct 2026 21:47:02 -0700 (PDT)
Received: from morise ([45.202.248.109]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e49f67cd08sm3729675ad.16.2026.10.01.21.46.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 21:47:02 -0700 (PDT)
From: Zixian Zeng <sycamoremoon376@gmail.com>
To: u-boot@lists.u-boot-project.org,
	u-boot-spacemit@groups.io
Cc: Tom Rini <trini@konsulko.com>, Jerome Forissier <jerome.forissier@arm.com>,
 Huan Zhou <pericycle.cc@gmail.com>, Guodong Xu <guodong.xu@riscstar.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Julien Stephan <jstephan@baylibre.com>, Johan Jonker <jbx6244@gmail.com>,
 David Lechner <dlechner@baylibre.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Eric Chung <eric.chung@riscstar.com>, Yixun Lan <dlan@kernel.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Guodong Xu <guodong@riscstar.com>, Zixian Zeng <sycamoremoon376@gmail.com>
Subject: [PATCH 3/3] MAINTAINERS: spacemit: add K1 Ethernet driver
Date: Fri,  2 Oct 2026 12:46:51 +0800
Message-ID: <20261002-b4-k1-emac-v1-3-d9be2ff07c9f@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261002-b4-k1-emac-v1-0-e1b6806b018a@gmail.com>
References: <20261002-b4-k1-emac-v1-0-e1b6806b018a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790915939; l=675;
 i=sycamoremoon376@gmail.com; s=20260926; h=from:subject:message-id;
 bh=NSvAjjoINJ8JY/CZkqHwNzi6pNsKsmqUkXAjJ6I3Bl0=;
 b=IS6YVhVqfx4WND5rMBh6kV7MvmRDZT5PxHUL1yDB+tsl8tC5dJ+OW6vBavIMOPm3QJabpqTCi
 kOZUaes68f9CPY7DAk9w9ErpI0BaJws8pSoaqf2LyhwOmOR0zlcr3Yz
X-Developer-Key: i=sycamoremoon376@gmail.com; a=ed25519;
 pk=xO+BwE3DuX3uCUVEo06fonjJtjMp0vUdCPuPP450qO4=
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 02 Oct 2026 12:26:15 +0000
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

Add the SpacemiT K1 Ethernet driver to the maintained files.=0D
=0D
Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>=0D
---=0D
 board/spacemit/k1/MAINTAINERS | 1 +=0D
 1 file changed, 1 insertion(+)=0D
=0D
diff --git a/board/spacemit/k1/MAINTAINERS b/board/spacemit/k1/MAINTAINERS=
=0D
index c1d6b8f3a1c..a9af13ab0a9 100644=0D
--- a/board/spacemit/k1/MAINTAINERS=0D
+++ b/board/spacemit/k1/MAINTAINERS=0D
@@ -10,6 +10,7 @@ F:	doc/board/spacemit/=0D
 F:	drivers/gpio/spacemit_gpio.c=0D
 F:	drivers/i2c/k1_i2c.c=0D
 F:	drivers/mmc/spacemit_sdhci.c=0D
+F:	drivers/net/spacemit/=0D
 F:	drivers/pci/pcie_dw_spacemit.c=0D
 F:	drivers/pinctrl/spacemit/=0D
 F:	drivers/power/pmic/pmic_spacemit_p1.c=0D
=0D
-- =0D
2.56.0=0D
=0D
