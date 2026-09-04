Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F37C79F82
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 19:31:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A28AF60B95;
	Fri,  4 Sep 2026 19:31:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s9v_hLUjl_Ee; Fri,  4 Sep 2026 19:31:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B34F860B86
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788550279;
	b=boG3HhA0Zi+28wSBpkPthujFND/XlSXoP+3fROQopL/vaQIbKWT7Q2X1o6HRme7OeGm7
	 FwKwvEXS4emcpoWOFYuAH8KqzDzbeseO8wUD3iNw56VnxFm1yCdTLxVZFOvdBlY2SdJq2
	 ofyMp6rjW7h5uYOjUbkmshP/8KKZG5r1tPSxPD1JSPmeldhUCQjRvkIBZLtKoameD6i5z
	 2XYRgcKg/4Gl1/V1XhL3SMSEOKwamICp/64U3mKNAOyhZyfN0bu4Skg2HQ7aB5rMqgMil
	 3bsBZ8SgvJkdJ2TETIV78TAq2LZ9eDD4KeAa8SWYzLXnEe2VNLVTzMW13UExFe7GMrg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788550279;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:DKIM-Signature:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=U877ZCIZ/e70cT0rg4zUHyZGqdJZNFZoXhNR2wQvndE=;
	b=dE7250tjIrYgteoaujIfpVZKmmIUm/7d+roEPzFfGIy5Cb+17lHImaCYasQ9faxk992+
	 h+AbyPAt9hgrNljciJPM2sKKHw7XRPDLx+aoh/ZNsEqO9MOvPAf00PyelWySQCtgpk1AZ
	 xY56GarpQnWZtqa8BH15QhEkMUrJgqNa1nhez7yieXnewp4paUBpjmRj+c//wmEV5Ug/L
	 h0ZOIBR9GPIbvGO2w0q7hnx+NEM5ZVplFtQf7z0UtQ4AfydL0grHzQ7o8yoDPP6pmygoO
	 Q7gIXXB19E6DTd9Epcu/iwkZ9AWTmbea+2XNGqBrQOIXdJeSAGyEpLJBazBwLjADZ9w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788550279;
	bh=U877ZCIZ/e70cT0rg4zUHyZGqdJZNFZoXhNR2wQvndE=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=IPWJEULITWdkav7IrTj0dBiSxNYiw40Hr0wqA3jvka4kejgPFH1DquemTF7JpLJQ1
	 lnJh5ULYT7I53k6WyaZyVEoKNQtSTYFi7AoqBgiBQ+BijFfRY/OZpGX7TLgmGNJivJ
	 gIchQQlk1A+NS2G9WrqT1f3G/zhpWeRGaVzAR/qedHRIlbgFhyqXbPfGgiTIGTMISl
	 u+D+tAX4y2kog99HzbWmKuHoqRkmJlbkLh4+wh4tbYn1grZXvFi9XPes7vmsp1xIRQ
	 3FQK93rhdMhy6vyFwAIhCzggA056sA04xC6+gfCDmwNaTcI78KiN7M6LaGOYdAfSDM
	 /9wfpr1yyOmwA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B34F860B86;
	Fri,  4 Sep 2026 19:31:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 64109724
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 19:31:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5615C40A67
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 19:31:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w7NA6ZzVd54j for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 19:31:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 3D0B640A76
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788550273;
 b=UpcOTcysGsvgQjdQV2/0wJSVFIXpXlvVylBR9ikugqwB68GivzBgF/Nm6aPiBwLEQJlY
 vXX9HoPSNdc5ZVsTFbujgxk+/0+nORm6MGTXzG+ENek0nKl0z2lRcaSrue8xw4yjE+0O/
 xOdK02+31D5k1alMW2W/oqNqylTtFIILl2CVzRPHqCzySI4qeS6LlC5jxVL8+W3jexXmW
 9qhgf38p9XjW1weVpBndTaIAwSXfavDhr3E23LcuqCPkuxh2FW0sjWB4JjiojyVSnl0wa
 DKbo0o64ryg0jibw1T/SLTuM0B16E6PHr1H+99ECfLdWX/KQ9tdT7DuDfexSWuC7eXQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788550273;
 h=Received-SPF:Received:Received:DKIM-Signature:DKIM-Signature:
 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
 Received:From:Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=U877ZCIZ/e70cT0rg4zUHyZGqdJZNFZoXhNR2wQvndE=;
 b=Fv49BfHubbK0wtkFR5kTHI1PWvZML3D3YOmR4KioSj0sYMhmpfk1frTgUNVhGgoEVAIN
 auVxQGkRRkCT/34TctRtjvO0tQV//gZsRy7mb0ScklprNn05aBJrRl+euPyWzWYAqGuBM
 COnt/5OZP8qV+i52IvdMOOFx2WPaHreLuWEQmPUt9n9G4Ql2Fv3aOPKgFOaqzJvvauG4M
 aRv0sW5zTEwSRNoLjoaRhpz+9Dys1NLX2vittUPvlrTs8Uvtdaw7SZwjYTvSvati54A+q
 U17YY7GwsurlQQ5Ci6lbHyNC89pc3iDYqQFHDUamgkHK+cp+IDNSBtRfLCJrHPj0pkQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=jannau.net; 
 dkim=pass header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256
 header.s=fm2 header.b=PgsZ0bJ8; 
 dkim=pass header.d=messagingengine.com header.i=@messagingengine.com
 header.a=rsa-sha256 header.s=fm1 header.b=rms2asmk; 
 arc=none smtp.remote-ip=202.12.124.148
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=202.12.124.148;
 helo=fout-b5-smtp.messagingengine.com; envelope-from=j@jannau.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=jannau.net header.i=@jannau.net
 header.a=rsa-sha256 header.s=fm2 header.b=PgsZ0bJ8; 
 dkim=pass (2048-bit key,
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.a=rsa-sha256 header.s=fm1 header.b=rms2asmk
Received: from fout-b5-smtp.messagingengine.com
 (fout-b5-smtp.messagingengine.com [202.12.124.148])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3D0B640A76
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 19:31:12 +0000 (UTC)
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
 by mailfout.stl.internal (Postfix) with ESMTP id CA7C51D000C3;
 Fri,  4 Sep 2026 15:22:56 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-08.internal (MEProxy); Fri, 04 Sep 2026 15:22:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm2; t=1788549776; x=1788636176; bh=U8
 77ZCIZ/e70cT0rg4zUHyZGqdJZNFZoXhNR2wQvndE=; b=PgsZ0bJ80Pi4JzUSez
 RFckXdKjsAYYc3MfdeV1IO79Hx304TtqULgL9V8wrGr8h++ycs04Dr3JuTAQe+Gn
 F/N8KyxcfPO/HRkSxDL76RJ8fvFNtO9Bnw5K0FByO65P+b772PhHA8ogyc+cJ624
 /ouZPx1/1dDA7XB/olT+pPHeyYB+04jRAkdLULBqz1sV2oCa702xhkSEg8FSjnmh
 jUCD/5JLKcbrh3cH39Uv2SANfvX/2yJh1JdFdomGiYEwEenWoMCNdXAy8fm6Mr/s
 FM+AvOfxmTYQuxEHql0hNeAnunpzGSMnlHoKEl6Zj7tX5MN7n5+TT561B+TUSYQR
 2Mpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1788549776; x=1788636176; bh=U877ZCIZ/e70cT0rg4zUHyZGqdJZ
 NFZoXhNR2wQvndE=; b=rms2asmkV/Lj0xkbSqoqAJMHSrfII9fGyST4Hxr3hw7m
 U5s/PK0B8YJ0Impu/EG6aFdyVraGQQgqvA0YPJKxNWSa+bGA47FLKgQ743lz9a0j
 tpFTVpBA4Euk7xk7QCXfHuPtn/6vTEJMYcBctgH5IMp7mmItb+Omo+WdZvHhGSFX
 Qm9OyKiOQ6LkxISJ/mUYOSbJKtHgVqvEWmrWmZFD3i/4s9A+KLgGC1uUd/W96YPu
 OqgtYMZTr/EjN+mmIZDsR6MTLi0+TdLL9NBMo30dDPNm9PzQ4d4BJB2oBNxmzV2S
 o41RbdcJGo+nun3NaCoE4V++lJZfqylV9u1MMaNIIQ==
X-ME-Sender: <xms:kBqbahBU7B-11ob4Bpa5dylRtTI6Dh2bBWWaxu5h5AneMoZYAzN_Dw>
 <xme:kBqbakfgclfdewR2rUaxVv_HV-ad9yNRaArQwdXBV7UmxuwqsUtFT-_zYhaaeNihp
 SBocIWZhYhwTgCxrUBtec12TZD3utHnSvTxY27FZAuztX0__T57gj4>
X-ME-Received: <xmr:kBqbag14XUbVzpzw5teSOYtTneBKiYI3POAGA0ASptljPl-MoqrmJj2C5ndj0pO6UAYrefS3zzVxx44euR3RneHAHxrTpa_iABj1_g>
X-ME-Proxy-Cause: dmFkZTE+ekJ69lfqHb5BQ0m7LaIMVbMjv65iK61w7SOYnxxEulc58zm7mx6o/oAQvIjJkJ
 BwcVa6Ri2NdsxzJaRk0T2iRzoad8L/n/Q1UzWZVeoBNI+vO55zfVmst3RqP/fQURQ/lIkx
 vBIiKuux6W2INvtWYpXLYCmmKBvF9pIgSoyAQKtm9JICq8VxnBKIZTcPsiaeCiXAgXj7af
 QlHB91jhFQUAYdsUDqzklgZXRK+kMWgw8NZwq3MpUj5EjHWVsvpfljgPZ3AS9agKZKz+lr
 EdwADcVTcqsYWpYhZaa7+qp8DIU9ijZaaOBxecCk6lbNPPgpCUD6DCGXsCN4bSlUgYjRAb
 LEnk3GEBttFUiR4yd+TJQnEx6KmrxJqmM6zZE8ImwKFuirkgL/ugrWXMUf878aVsSDbRaa
 lahvEKiSNB7JsPMYsxwOPPdygsE/SQKTaL3ZFL43Fkkp2DB9dzznMMlGUkoQUq7VVG2tih
 A64WuEjPC2q2/9zcjyAuYkLb6VnzRttd/jNFbVaM5Rum9j039YObyd2S5be/jkdZp+oL5r
 P8pdHo9m12jcMVpYNltfWdNqzNIS9RUGHs3Qwcab533QJd+oMopC9hAcznFJweuM1sPjcO
 w0kgKM+fXLlsDBHK+l+3yTQvarW28DYL3nUdLvsVrPSGLl6O8fsanPeu5WSw
X-ME-Proxy: <xmx:kBqbariBRfM8T82jkbOu5WhLqVKafcMTKQZxhHU_7gldee-YEu2Y2Q>
 <xmx:kBqbapmHyvVft8SRKbF5Q5LSCwhz-9I0xHcFrSrRWUmgkYfg2N6m3w>
 <xmx:kBqbahYZ58NERmTp0XIuivVQtQKuh0BpOkmoUkK2pZQCP4EYpnqk6w>
 <xmx:kBqbakGr3bGNq7TIVFjdevWYPUzlUet56lj_IcRbn1GJburx7DvXAQ>
 <xmx:kBqbal_ceC53ghbBhGd0rvKgAwLk17D1whNKFu9gLXpW8OX7oc3ylqdx>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 15:22:55 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Subject: [PATCH 0/4] Apple NVMe fixes for macOS 15+ firmware / M4 support
Date: Fri, 04 Sep 2026 21:22:38 +0200
Message-Id: <20260904-apple-nvme-fwabi-v1-0-f7ede661c469@jannau.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avErBswkaKuEi3MZmqgTBQqkO6et
 HyL/zMkikIJhipDpEuSnL6gqStwm/UroSzFoJVuVa8M2hB2Qn8dhHzbWdBxZ7hzxNYZKFmIxPL
 8y3F63w8eKbn4YgAAAA==
X-Change-ID: 20260904-apple-nvme-fwabi-cf74f7cefac4
To: u-boot@lists.u-boot-project.org
Cc: asahi@lists.linux.dev, Mark Kettenis <kettenis@openbsd.org>, 
 Sven Peter <sven@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Francois Berder <fberder@outlook.fr>, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1290; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=gXjNtUOcdkzdOvxdJgDeknxiO+8qXYStItBYPIu4jeA=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhqzZUr15Lgo7prVMrnYOmCFvVcx08I1Q6PEHzvZ9GYkdv
 LrJV6Q7SlkYxLgYZMUUWZK0X3YwrK5RjKl9EAYzh5UJZAgDF6cATCT7P8N/j4j/dxcuuOS57Xie
 YPeMnbZHP7B2r7kty3KcrUfOe/eCZwx/JV7M2Wz2oqTgS6nsicIvKwKdBK/oLIzdF3JE+/Kbtx9
 5OQA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
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

Hej,

this series adapts Sven's Linux nvme-apple series of the same name to
u-boot. It fixes bugs which are worked around on M1/M2/M3 based devices
with NVMe firmware from macOS 14.x or earlier. Starting with the NVMe
controller firmware from macOS 15.x (required for M4 support) the
workaround is no longer available.

The quirk to require page-aligned buffers for the admin queue is not
necessary for u-boot. As far as I can see the buffers are always
page-aligned. Add noisy WARN_ON_ONCEs to ensure it's noticed if this
changes or I was mistaken to begin with.

Janne

Link: https://lore.kernel.org/asahi/20260806-b4-nvme-fwabi-v1-0-bde19ce8db04@kernel.org/

Signed-off-by: Janne Grunau <j@jannau.net>
---
Janne Grunau (4):
      nvme: apple: Don't set a DMA direction for commands without a data transfer
      nvme: apple: Never set the opcode in the NVMMU TCB
      nvme: apple: Add WARN_ON_ONCE for non page-aligned admin queue buffers
      nvme: apple: Drop the PRP null check chicken bit

 drivers/nvme/nvme_apple.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)
---
base-commit: 964ad5b5c91b7be56e443e899d7f873e6aa8c9fc
change-id: 20260904-apple-nvme-fwabi-cf74f7cefac4

Best regards,
-- 
Janne Grunau <j@jannau.net>

