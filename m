Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B987CA9ED0
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 22:28:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4428140564;
	Mon, 12 Oct 2026 22:28:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wE7x9PkjkokH; Mon, 12 Oct 2026 22:28:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 36D8E40525
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791844082;
	b=AsXTU9tpesNcVMTlq93yDFsLGhTXQ9wKsu6OzmNJoN8wIk6CxbLFHrKlJdEBdNfZERqY
	 7q9vK6Nzg/Q8J66Ajz26Z2LOLYAD+Lv0m0fzKTMtRo0r0EO+WdLaXmg6G79sgOIcPx8su
	 L0RgA0IRVFzYL4BD66vBGerqrpKg3RPApX325d8RKaQyDwB625S3WHG+Am7NGSgfgqUJV
	 FndF0RurpQSNBFCMbxLsK3jLVK0gTyuEZbEwQHhbVdzyaloJ25eiV7RieAtP/Akzx7gkQ
	 cY5G68TG3cTOyR/wFItgHaj0cxINN7W+jfp9IKZeZLS4WARgTbgdnx+g4E6L0RC4Mkw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791844082;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=00JmhKwk40xo0ttfImor5tnCFRHjUrFiYFmiAhXgbJY=;
	b=rBAHYpYUSssyNr2dNUu0dsXPAA2mjyQpT1aYec6xWRA8fxTNxf31SiNq3xlKKGliZjec
	 y534FVzGljoVaUsWTSp7fnuxa8qLuRmf4a1z8gsXGZ/SLaWFF8NuH4iQdyU6loCSjdAAU
	 5Z4BXe3jEbRhIOKeP0w9e5MRiIevHS7YkyLoKsQTA3hScR1fQ/B6XH0OViVk+47QAz941
	 OJ1+zO9SMQ2bFlb7Phq3cerdIV/EoTZ0gqwEnFT+/3j8waXLkSK/ugMDBQAsVADVd8nBF
	 fJQln1G8SHjI/tnhVjVkaW7QiFnvHBJJWwHEvYVscnotEzGWygzIYLbR51RCkedQGuA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791844082;
	bh=00JmhKwk40xo0ttfImor5tnCFRHjUrFiYFmiAhXgbJY=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=RderjePoZJIlZ/76NgoIQzfA+4osHtcIdMBIcOFoU3c5fQIjXLo0ITP6bqBwJAI7z
	 HXlsRfKMwf03RabJbCSdC9KLrEYC61wx5CqapWI1pu5SpXO/WtXZ/VDH0QmbY7rBqM
	 kJ7I6dfD5bcq9xEFwqZ/APYTnrgNT5hxiAAfC5rc4JADgGEQEgpBu6Ryp1RKHorEiR
	 aNm0/a6AO+csHOxEPIz5vWBjTEQN+AtF823pIjt6iFteyiut1AtKrIrGRrhIsUsjZ1
	 3by7cBaeDyInPVStOO6Zy/VZuMhSo5zCPtYTKOf0jLq5D4CmnEumeLqgpHXVQZS6l7
	 0ZHTMaGzNANgQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 36D8E40525;
	Mon, 12 Oct 2026 22:28:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 917CE4DD
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 22:28:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8DED1606F8
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 22:28:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V80sbGAtqJQi for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 22:28:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 996D3605D9
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::2d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791844080;
 b=eXA6N/SnhO26BozlSUq0OIXDJvLzD4bdvW4eIIq7VVciIlxvVN48c0dIfilf5FBLijwk
 +UQrcCDjP7oq4U1A1h2aDJmFOD0o8eYF7J80jwITu7eNAOJD21+J+C8MGN1vB8KIcRFDE
 CcAF99VWwOrmjGOQCKaC9LemmQO7vn3QOHSEaZJEg48gsFvknvq3X440Oo2VjRiHLpmts
 MSdXgpNL2JicKGOe/EEZlXG1qnc2iMK5Dc3EGFldVuRahzCcjocDiR/brJZgV5N1CB53y
 uXLGrZkJ/5Da9vho71dHSoCpsPniPGIHMDfx0cX5t357cjsi7vX0Iz4Kaczo/5zhJDg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791844080;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=00JmhKwk40xo0ttfImor5tnCFRHjUrFiYFmiAhXgbJY=;
 b=ZlpsXeHwLaczLvisYmfiPGy5E49Ogr5yd1NJnaVrEOeSanqkUBIYZGG2cplECZxXnKGk
 47GPLMaxyuLiiozcmMC0VGMoD3TsnwodbIzVWa9RrrMO6qnU3VcBs6NC6l/4H7sCpull3
 8Rqav16TrJDaMuHd3XV9/w9r+S5byO2DbafIVkdH0No+f0enq80WE8oEarT1X3aLGTQwI
 pdhOcWoCZE/hXWJaghpm15kzZ7kg6yi6R2QF7U4vHvP8vOz5O2h0Y1Ib8yCIeoBPF71uI
 xwWKcW0qqgCJKzYm5qJfJBG3po/0p4Pfnr/LBTF7+1EWpDXLg2iBY3qlTIpjTlhePpw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="A/M5bOkK"; 
 arc=none smtp.remote-ip="2001:4860:4864:20::2d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2d; helo=mail-oa1-x2d.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=A/M5bOkK
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 996D3605D9
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 22:28:00 +0000 (UTC)
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-49dd13a91d0so869370fac.0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 15:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791844079; x=1792448879;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=00JmhKwk40xo0ttfImor5tnCFRHjUrFiYFmiAhXgbJY=;
 b=A/M5bOkKZnnraFic8TAHQIwj8VgaHeZpzdIA0p/j6UzZa4dAPYTQYDQ7UUbh2NLIJL
 firqcEtEZxb4UvywvPEv5JnvrIuzMgI3ZxzLPq4odDS+njObzm88w/cLD7T4TV80bH/1
 7Fvvd3I3+KVRasAyxc1iuMQwuDR47DfCNp05nI46CmqXoJmVICP5rYswhXC8LX3wralk
 IMH63pFMIYKDWoA5PsI1yymqSh5Ymrq/Hfd8gemWOwmHwHfxU37KEby1rv+z8w8UEkg9
 1OK0ovrCdPz7RnZXRv8EwmE7zS6ZnwiV40E4erl4wIc6IwTSn7OsZKW36VItqwLqMYjU
 8l/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791844079; x=1792448879;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=00JmhKwk40xo0ttfImor5tnCFRHjUrFiYFmiAhXgbJY=;
 b=MHaHxmX1HmAUeXOPjfiAjtxolenjEQ6G2eJFWBj2bmWndjsC1+t/t8/upyJW5eU2aV
 AlOc+la8Y9265mYUoYoPoiCRqxMnRM/XFf9RNlp5qx7jPG+SVDuFwMbDBQcv7sN4Impb
 ZJ6NBGUzAkfzoBHeBTIsOdSUdqCo+gM2PpUr8sV9y+hQoRnG3r9fkI1eK2NKqQEn0i5D
 KUzRrDnArWxB3SUHECWspyxFxiOPO8tzVXmvIEJPiw6cMGshqE360RUB77EfPWXr/K9k
 PxsnIzLtKcudHmCcbovMJu/emnBrGoLgY7fSAy1MOlspMYjczhq6IAjjNd4uOoZrzPH1
 1DZw==
X-Gm-Message-State: AFq9FYL7wG60bS7sM1METtzjmH8o0a5D88CXU1fMuRXhzSLDmJ5cyy25
 D/GRNSac5gUrsNLnVYbmkv3bi73EsFBNUg/BSGwEG9zksNS1mH96F0ed
X-Gm-Gg: AYBFou0rI5cpyXXdCvM2oiPLFf/OIHZXuo7rJkOOxm9OsgvGkmF4d5ftNFYD0xcCkem
 Zg+PiTJ5/xnNGKOJNWCtxzbAfaNaSn3V8qa65zEMi0Y5hKodOeQeXCD15V7c+zgIaFPBGMQjSK2
 fHaNucwXUSANHfdQLK9RH5WSEXwLQzZS0U2cwyD1kA6Nbi79vTq/xFJURi6MquWnusqDEgbGE4L
 Aa9GOKJ8lDLloyUPB4Qq8MANO8QK1UCV2uc+7Dd0D3m8kyeBGRsD2/FZTJChO9m/7OioT6Z/qhi
 UVPNOH3mxawCmF8HgQzMp/80vpcADcxUfvJi6TUsTTiwePRYwZod/DgwreApgwpqvoL0MInt+ly
 NhNb/AIuEGkPJq0VmPNT5W9ILVNxU+i5u95SwJ5vOzqxCwk0HxRtwcqXqyzofcseeR+KkrVQdkO
 WvwpGz1v7OCFYZvIaovGmMJu7/KXyFL2GT64wZDak98DrX2EGDxyTqcsY3/0P5zPeTwj5DakXFE
 7NxHsZW6XrQbK3S6uxgCAtdngv5yjOyQnd4/vbJBksI/PsN/h54gi4CmelIJSehfakgBrIKn3mi
 PwbrJ8ci5HE47Q1LXstEVsZe/sW4Crtp/TcZQfd8FouzNuCYtN3r1QQJzQpLBjZvmyqBRJ1Darm
 H8Psp/yAN5HxfuL4RkWYnag==
X-Received: by 2002:a05:6870:179d:b0:493:286c:f4fe with SMTP id
 586e51a60fabf-4a2a89dca38mr8807785fac.19.1791844079004; 
 Mon, 12 Oct 2026 15:27:59 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a2a8582a95sm10402859fac.11.2026.10.12.15.27.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 15:27:58 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v2 0/8] net: return -EAGAIN when no RX packet is ready
Date: Mon, 12 Oct 2026 16:27:55 -0600
Message-Id: <20261012-submit-cpsw-rx-eagain-v1-v2-0-c6a20425c15d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OXQqDMBCEryJ57raJoP156j2KD/lZdUtNJInWI
 t69ib1AYWH5hplhVhbQEwZ2K1bmcaZAziYoDwXTvbQdApnErORlLbgoIUxqoAh6DG/wC6DsJFm
 YBShjJG/rM685Zyk+emxp2asfzY9T9ok65r7sUDIgKC+t7rM0gXIugsV4ap1Pf4nZ1VOIzn/2h
 bPIbX+MSSeAt8ro67kSVX25d4Ok11G7gTXbtn0Bhopoi/gAAAA=
X-Change-ID: 20261012-submit-cpsw-rx-eagain-v1-bdda0f670600
To: u-boot@lists.u-boot-project.org, 
 Jerome Forissier <jerome.forissier@arm.com>
Cc: Tom Rini <trini@konsulko.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>, 
 Anshul Dalal <anshuld@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Pranav Tilak <pranav.vinaytilak@amd.com>, 
 James Hilliard <james.hilliard1@gmail.com>
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

DHCP now checks net_lwip_poll(), exposing Ethernet drivers which return
fatal errors for an ordinary receive poll with no packet available.
net_lwip_rx() treats -EAGAIN as an empty receive, as specified by the
Ethernet driver interface.

Keep the CPSW fix from v1 and fix the same issue in seven more drivers:
FMan, ColdFire FEC, Marvell GbE, TSEC, Xilinx EmacLite, Zynq GEM and
HiSilicon GMAC, with one patch per driver. Change only their no-packet
returns, preserving packet processing, actual error handling and polling
limits. The driver fixes can be applied independently.

The additional cases were found by code inspection following the
BeagleBone Black report. Cross-compiled the seven additional drivers
with both lwIP and the legacy stack, and checked their receive functions
with stubbed registers and descriptors, including negative controls
against the old code. These additional drivers have not been tested on
real hardware.

Based on u-boot-net/for-next.

Assisted-by: Codex:gpt-6-astra
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes in v2:
- Add separate fixes for empty receives in seven more Ethernet drivers.
- Add Tom Rini's Tested-by to the otherwise unchanged CPSW patch.
- Link to v1: https://patch.msgid.link/20261012-submit-cpsw-rx-eagain-v1-v1-1-0fbdc9751568@gmail.com

---
James Hilliard (8):
      net: ti: cpsw: return -EAGAIN when no RX packet is ready
      net: fm: return -EAGAIN for empty receives
      net: higmacv300: return -EAGAIN for empty receives
      net: mcffec: return -EAGAIN for empty receives
      net: mvgbe: return -EAGAIN for empty receives
      net: tsec: return -EAGAIN for empty receives
      net: xilinx_emaclite: return -EAGAIN for empty receives
      net: zynq_gem: return -EAGAIN for empty receives

 drivers/net/fm/eth.c          | 2 +-
 drivers/net/higmacv300.c      | 2 +-
 drivers/net/mcffec.c          | 2 +-
 drivers/net/mvgbe.c           | 2 +-
 drivers/net/ti/cpsw.c         | 2 ++
 drivers/net/tsec.c            | 2 ++
 drivers/net/xilinx_emaclite.c | 6 +++---
 drivers/net/zynq_gem.c        | 2 +-
 8 files changed, 12 insertions(+), 8 deletions(-)
---
base-commit: 28ddd369e2f7199539cdefe22ce014c592b890bd
change-id: 20261012-submit-cpsw-rx-eagain-v1-bdda0f670600

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

