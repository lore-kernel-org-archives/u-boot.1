Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E3CC5CFCF
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 17:59:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C3DFA40C2A;
	Thu, 13 Aug 2026 17:59:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XuCis6Uan56o; Thu, 13 Aug 2026 17:59:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 084E940C2B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786643970;
	bh=kwWx/5kxSWh2Ec7obO86QDtHOE3I3xrEqfL/3nIeiko=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=r9kqA9wteVWO/f69hkIoXYJM6XB+0TBTMC1dZpeEvGcstXWynH3m9TEnQ9+RGVWuI
	 QqhktDjBGYQrGHUjT36oS7/5fOZYzEvMdAWBmfd+hWJJbYYpk8WIHZpYvA7+t1LGAb
	 kfZIti+i9/10FFRrnvjVTKmMv+3ui4A3Fr5dJiJu/3u45uSojTu2uczBbulatQrELd
	 1HTWR1gzUfZViyCd9jjPMd00LMgL8m8aWTz1/ZguHeWZDSIgB64pJB4q8j+m3yS7FV
	 KsCdyara6ByelMRjy1nWkGhtKfpx5PSp9uFD27mR/ny8OihoJH27gc+Wn/6pWjYY6E
	 OwkWX9Xsperxg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 084E940C2B;
	Thu, 13 Aug 2026 17:59:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id BCA8D323
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 16:28:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AE2A74016A
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 16:28:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PFkw5G9Nr69c for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 16:28:38 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com;
 envelope-from=shahriyar@byteray.co.uk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B87CE40158
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B87CE40158
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B87CE40158
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 16:28:37 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-69fc9f25118so2650621a12.2
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 09:28:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786638516; x=1787243316;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=kwWx/5kxSWh2Ec7obO86QDtHOE3I3xrEqfL/3nIeiko=;
 b=EqJKoB5ATi6PHPrs3xFFt1blB+74Xg8dukKTMOyeIEKPcVcv8LQuDvMzxT1EoKhVKu
 S5lElpZWrVn9xlNjFjkVhfJDcmZ+yG9oIlcsZR/iLDGXKI7998RkrsvPerArBqysZGF+
 vCEj79c77d41HcBsj1SOdApg//T0ABuoHeaaaw2aP9pppW+Xn0Fo8E8QD6YcJuoaIFL5
 TDsWeaTBrIQ4hNdpG6up78Qcc5KZObSzPKEThAlvcSA5BVw63dUTh0C7zHfI1NVaCLyk
 L5JgNnbmyUknPchP+IBkbf5Acdr49/exyBZqix8zk8uq7UVOgSqGrUphsVAw1mAJQDDv
 crpA==
X-Gm-Message-State: AOJu0YyEJVxqR66hnCMr3SblOD5UIcbahugSuAdPedkuU13sgKvYYXDQ
 XE8Vcy1WNDdpSItXOpb4dLtlU57DaqJgluM31yXC1VyUDYoAVEFVb9d798it9Wr7rjY=
X-Gm-Gg: AR+sD12Dw1xx+cYXmZ74i8XUnF8Rq5dyaKw8yqzYDrTurJqwuoykKcKXUZiSme7Wwh1
 c+sHGpEejVIiz00IFRen6PitswQaawAApAWCLsHBanOAT+gnCP7T+G+P5e0OT0nVD19zRX3fJDe
 fag9kDmXama/fufyH+qDwzXnGpX/FEkK0pUJ2v0C/9V00LEJ3EG4COkrEPoFEtB3Dm1GwZzAQ6E
 ufnM5WV/c0E0k3bggyug4aRJBIxxZbcVCZSeZX3eVhxUbm4Uszz7VZFeqNMP9BUcH7dEHPGin+m
 J+sdFoAtf5cVL2aUDV+wEWc/J0qZfPerXuoyYvQWDwp//28PHlHEtkx4v8b19mv5G7rVkADM5+0
 nqiBLFOb6a460x9pfbcjU5maUucQG3HgYnuz8EsvxCVACNwzaI6zHHU+K+RsEGuG2iqn4xdF4YX
 ZmqI3ucdN81ymYnISaCbabnDSH7v5C0tZtRJN3CvnNO5l0ULp6a2qAY5raP92b2KZ/ejclBrGye
 A1PPw81T/gnq9ghCEpo2nbnckbJwb0E3v6XrLVqJaYKND/7faYF
X-Received: by 2002:a05:6402:510c:b0:697:e953:d14d with SMTP id
 4fb4d7f45d1cf-6a380732100mr3166599a12.17.1786638515685; 
 Thu, 13 Aug 2026 09:28:35 -0700 (PDT)
Received: from [127.0.1.1]
 (p200300ff0f038f00b49b9d175e416b42.dip0.t-ipconnect.de.
 [2003:ff:f03:8f00:b49b:9d17:5e41:6b42])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a37f7f59afsm1139188a12.11.2026.08.13.09.28.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 09:28:35 -0700 (PDT)
From: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Subject: [PATCH v2 0/3] net: lwip: fix use-after-free bugs in the wget and
 dns commands
Date: Thu, 13 Aug 2026 18:28:16 +0200
Message-Id: <20260813-lwip-httpc-uaf-v2-0-1c3f0b3aa1eb@byteray.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKDwfWoC/3WNQQ6CMBBFr0Jm7ZCWRkFX3sOwaMtURg2QtqCE9
 O4Crl2+5P33FwjkmQJcsgU8TRy471YoDhnYVnd3Qm5WhkIUJ1FJia83D9jGOFgctUMljauOSpT
 GEqyjwZPjzx681T8Oo3mQjVtlM1oOsffz/jjJzfsbnyQKPDthdKmUbEhfzRzJ6zm3fT4+oU4pf
 QH5wtpUwgAAAA==
X-Change-ID: 20260811-lwip-httpc-uaf-31bf85307bce
To: u-boot@lists.u-boot-project.org, 
 Jerome Forissier <jerome.forissier@arm.com>
Cc: Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>, 
 Argus <argus@byteray.co.uk>, Shahriyar Jalayeri <shahriyar@byteray.co.uk>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Thu, 13 Aug 2026 17:59:28 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1786638516; x=1787243316;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kwWx/5kxSWh2Ec7obO86QDtHOE3I3xrEqfL/3nIeiko=;
 b=s4c/rN1bjfBbFNYBoJWB6QZK6ngLdv7lBM674FjvuyV2GT1ZLDuOC+tUMHkO94k7k2
 9JMIFwVRupSXjY3smpKykS4CFgYf8y5u006q1IxBWP42aHQz6qqMK+njzHXPCP6nZ/qU
 uJYc07kI3nBW9QcxMM9uSC3nXuo38j20apapHM5wmNLoC52W9EoPYjNqtQ53ytkJ26xE
 VIfKLX3Z74qywcaOOP5BKWLPmgZO8VV+20hzxSP9s0VaqOTuUus0QQYROlXw6EWDjYpt
 E+b9qT8Mw2CGRgf0jpsPOsZhwB08d7g2nqCejJbBsNmqPNHxEt4pgnI0msIZ6SqSFcNe
 dS+A==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=s4c/rN1b
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Three use-after-free bugs in the lwIP wget and dns command glue.

Patch 1 fixes httpc_recv_cb(), which calls altcp_abort() on a store_block()
failure but returns ERR_BUF instead of ERR_ABRT, so tcp_input() keeps using
the freed pcb.

Patch 2 fixes wget, which keeps its transfer context on the stack and hands
its address to the httpc callbacks. Ctrl-C while the host name is still
resolving leaves the connection up, and a later callback runs against the
freed stack frame, writing attacker-controlled data through store_block().
The context, together with the httpc connection settings that lwIP keeps a
pointer to, moves to the heap with an ownership handoff to the lwIP callback.

Patch 3 fixes the same stack-lifetime bug in the dns command, for its
dns_gethostbyname() callback argument.

A reproducer is available on request.

Signed-off-by: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
---
Changes in v2:
- Patch 2: also move the httpc connection settings (and the TLS allocator
  they reference) into the heap context. lwIP keeps a pointer to them in
  httpc_state_t.conn_settings and dereferences it from the result and
  headers-done callbacks, so an abandoned request read its callback pointers
  from the freed stack too. (Jerome Forissier)

---
Shahriyar Jalayeri (3):
      net: lwip: wget: return ERR_ABRT after aborting the connection
      net: lwip: wget: free the transfer context after an aborted request
      net: lwip: dns: free the callback context after an aborted lookup

 net/lwip/dns.c  |  38 +++++++++++++++++----
 net/lwip/wget.c | 101 ++++++++++++++++++++++++++++++++++++++++----------------
 2 files changed, 103 insertions(+), 36 deletions(-)
---
base-commit: baa64b2f892890f00a377eac4a3e685472bb56b5
change-id: 20260811-lwip-httpc-uaf-31bf85307bce

Best regards,
--  
Shahriyar Jalayeri <shahriyar@byteray.co.uk>

