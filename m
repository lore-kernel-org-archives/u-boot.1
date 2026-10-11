Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46562CA9ED1
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 20:13:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DCA6F4066A;
	Sun, 11 Oct 2026 20:13:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v-XJ6x1NW919; Sun, 11 Oct 2026 20:13:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 88EB340652
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791749582;
	b=Ico8WBs4hdN/ZeIWRcEn38Ipc3Eqy77EYd0iro9Xe/N0OEfvkFPkdj4iBdgWrjvd7Ny2
	 tOBI4h3DL77EUIiSU4nHpUhQzICgqUGmahvIsK2iXtBxv4nbP+rnENWcw7mTHtyPtx3Ns
	 Z2DgFwhU7Fk2HJXwGIrTRY5fDc1efDb5N0Lt8OO8ZZkX+6ElbE0N1UeUTNi36M0XVMPBv
	 xTG/lgpXSA+JzN4wWZOfZYtOgjgfDcuNakZOnFU+bRDN5IYcEl6mHIKsS1Eh7XCJpJBWb
	 rkJTwfz+9XF1kayNhhXSNEodkc+Zzn7ginHsyoV3zpa0VjDEctg61Hupz6zFtudr5Sg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791749582;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=QnUmUr60LIIDm1HLwh90Byirt9Qz7EwNofO+e+D/NHU=;
	b=QP2EDIynwqWIFyPPh3AYCRLaK82mqbE3n8AByHW3MajdLljSaWhNUoDYxYZal9QXQIDD
	 I/u1X3T9YCZ0I4HFiIZD66Yk2SA/8+5G/5ITBJsYrS6qfkDfpV6whPPPd6yGlPPgVsH3z
	 Av74WU8GkC63p4fwJr21NjbMEaC7uyC12rcyKhWN4KMY5pIRweDPjvlpstIyoh7PcbJ88
	 wfgprroyBJyumi7m96nUwL7jSgQAnEwGp9LAKf3eCZHbhhxTj69sSVNGPRMydR7fnP1sB
	 SGDRQtA1kDntQxVZmJnT3MPPBtqvZV6Jcm7AUMmKi3cjC+3zTzqkqwoxTj6Bnj7pVTA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791749582;
	bh=QnUmUr60LIIDm1HLwh90Byirt9Qz7EwNofO+e+D/NHU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=MrXu5q4PXGsSp1P+RRovCdh6HhurzI+CtrWSJQlsaCxo1Gu0ESfU6FIEA2Lrq4vyt
	 988tRzlUAuMkmJzM8zEU4TbxrpXEuYSmgNiSgn/PzBXvJvpp3hfQFIiiitwAuiljaE
	 BV31RumH1+jYj2IU4l6f/Mpv4uUrA5mdcSlZoG+8jPQI1Wblf9TAFd+tHfarcQiZtA
	 rBQPBTBgqau+5bWM3BVSJr1zZQu59lkFdXCZHdWEOBMVrTp8CC35tRpEkxbtYFW8gF
	 QyNCW7ouRQLrFXxCW5pcpPzPKMh192kUL6yVhT1yOg4JFMIFZEscA9sjEVfx/kWkgm
	 yU4y0NENgFusw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 88EB340652;
	Sun, 11 Oct 2026 20:13:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 54726DE1
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 19:35:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 526A380CBD
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 19:35:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id roNjU0iPjx5G for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 19:35:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A619680CBF
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791747351;
 b=Ft5quO7IGeLeI6v/rN3shvVaU+VjeXDlaj5jnm4XbpXZkKTNjvbBHFtAduCj7wnKvTLn
 mmqdfs16j51ez0zt4Y1FwO3HDy5BIzT9lt1xvc0n3wu/vx7+4iW5norjquYc31iHaLLtt
 E1um12ESSVaVDUQEWUcOyR3Iie0Y2JbAJRDPyB+T+hPqOPh58CzQ73U0UzprAppMs5/VL
 y/YODDnCRCAUl7EQWmnnl4gLq3MimnFkLKeaZxAqtB/QvWFeLX0vgWXN4tMsGLlBCDg2a
 0MArGwDgbysstiCN9Y3Bx6SgVvZUA0SKQp0U0cbE7x2XjpwNgI4iwe7XdUHmnGteNHg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791747351;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=QnUmUr60LIIDm1HLwh90Byirt9Qz7EwNofO+e+D/NHU=;
 b=jfmV99XNhyrsWlv3iFf3MijVLYI4St1ap5c5IBuJbKBm7tlgfxmy4n6hMpaH4tqMpolk
 ypH6DBQZixukGDgf14hFdBJiSmnStRoaHpfIotmJFK1dzF5ZQyZ4GAeW635uI2dDzZNec
 nodQLznZhLVLiL6vbtjH92yVCNmbYmZam8PENrmbW9rzImYk3RLZj6zLfMQ1OHKYMcPIt
 pW0EesgNfVZC5JV4TW2tstpb/yO9DP0kgWThZiuyEPQ15s/gU+itqe7NKyTrOfolVmQW6
 CP9a4TAD5y6xOmOIy1g7MJdhuPL4S8O1b4NXh20J/Z/m9a1+h8RpM/YHbd1+tz3TzjA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=gyW4AAtH; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=gyW4AAtH
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A619680CBF
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 19:35:51 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 0673D601E4;
 Sun, 11 Oct 2026 19:35:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B1F59C2BCFA;
 Sun, 11 Oct 2026 19:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791747349;
 bh=DFdYT3WPAvviyaZ5sN2XTWm+0u66lIa/7ztX04gLWn8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=gyW4AAtHjimSaCGQdPtSRHRPZFwqAu2SWR4zG/EXaKfUCO6aDIo+UwNBeoUhF4hLM
 fOHObMfC4rnK48EzIfIYzfu9dU2RCJL4EcwtCPMaJiuU59mWokZGT/FYpO9J/di/2p
 /bN0pcDF9HGJYxdpQqZth0ZZxZ/0zQDUAWToEk5YvUytCTvj3wbpI3TzuSyEuHXjYL
 DzlzFFudZ4EhLef1ahk+bnGBog4z8mSA5NS0HxhSEuBjGgCtQKLma33xdb1X4sHTN1
 wQj9W3rsluIGpgCQz8IgDBeFuXdMFhIGMXDCG6kfvyH0HAtqeaXMpNdK7N9unZWaBu
 GOzdizI6QXN6w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id A1FD2CA9ED2;
 Sun, 11 Oct 2026 19:35:49 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Sun, 11 Oct 2026 21:35:51 +0200
Subject: [PATCH v2 9/9] configs: pinephone-pro-rk3399: add a DFU alt
 setting for the SPI NOR
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-b4-pinephone-pro-defconfig-v2-9-6b7be35fbee7@protonmail.com>
References: <20261011-b4-pinephone-pro-defconfig-v2-0-6b7be35fbee7@protonmail.com>
In-Reply-To: <20261011-b4-pinephone-pro-defconfig-v2-0-6b7be35fbee7@protonmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Peter Robinson <pbrobinson@gmail.com>, David Heidelberg <david@ixit.cz>, 
 Ondrej Jirman <megi@xff.cz>, Tom Rini <trini@konsulko.com>, 
 Petr Hodina <petr.hodina@protonmail.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Lukasz Majewski <lukma@denx.de>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791747347; l=1003;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=eGyCJdERnylhbqAjbK86HRy1VXAZKm7uISg9fD5Z5iw=;
 b=2wQRLM9AtBNjzgE+lM/BklRlrnth+8VnE/BnJIcweshoLigmZaEflPB+xNOqZ2UWrDfq2jyxH
 BK9eStYvfhnCPSYG81Kz3FvKbF24dK4QlPwsDZyrpbpH9O0sXnQfwre
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Sun, 11 Oct 2026 20:12:50 +0000
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
Reply-To: petr.hodina@protonmail.com
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Petr Hodina <petr.hodina@protonmail.com>

Define dfu_alt_info with a single entry that maps the whole 16 MiB
SPI NOR on bus 1, chip select 0 to "u-boot-spi". With this
"dfu 0" from the U-Boot prompt exposes it, so u-boot-rockchip-spi.bin
can be flashed over USB without going through maskrom:

  dfu-util -a u-boot-spi -D u-boot-rockchip-spi.bin

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 include/configs/pinephone-pro-rk3399.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/configs/pinephone-pro-rk3399.h b/include/configs/pinephone-pro-rk3399.h
index 9cd44473439..9e5d3800347 100644
--- a/include/configs/pinephone-pro-rk3399.h
+++ b/include/configs/pinephone-pro-rk3399.h
@@ -10,7 +10,8 @@
 #define ROCKCHIP_DEVICE_SETTINGS \
 		"stdin=serial,usbkbd\0" \
 		"stdout=serial,vidconsole\0" \
-		"stderr=serial,vidconsole\0"
+		"stderr=serial,vidconsole\0" \
+		"dfu_alt_info=sf 1:0=u-boot-spi raw 0x0 0x1000000\0"
 
 #include <configs/rk3399_common.h>
 

-- 
2.55.0


