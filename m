Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09072606A32F
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 15:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zc0stV1N;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RkQPBGl0
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C3B334043F;
	Sat, 31 Oct 2026 15:02:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sFZ2-7lIs5UY; Sat, 31 Oct 2026 15:02:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0A17C40441
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793458935;
	b=ZrzFbwN0w3Vd9e2V3GkGXwi38/4BtYWO3qoH/D8zFNJWqs9oPWTVl6Jnkw9BrtGIE+ei
	 yd/NITv+ItVO/TKqf4xGyfG9p52GuCd5gi7+Sj1LNefXUwP5UQHK4nczSNQ5o1Ka2YM3X
	 dBD/TiWmx/+wju6jiCLp01eO0UI7nIsNH8Oa55qUSZjCgrSFRZ5y0kmXVMYreUgAiDFkV
	 tANLCgF+45pE5TcmotB6hdkpsqwAs9ps5oVLNAmsan18MgWRtca3b8W6NcTZfRoUxXxmB
	 TSHw1Ts5GA4K8vjYn6aOkdaUpdhnfvXcq2hno+6K2R+x4VlHZedfreodjtksaMqik7Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793458935;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=nknIhTQlaIhRAYJU3CB5jE7Z3He1Ku916GtW66yynDM=;
	b=qKx3+3sWfcxsPheS1eeNKXM3YLHR11Wm/qXZGeaHF0RFSUlRDo6OY3Ks5/MJOQTyQebu
	 6TXu9+zcFBgof3MjGf33scXDyYVjXD+Zx45Ar9pCCFf7Ml2rZs6qBfxXQhQcspmgGzAbx
	 rAv3jevtkBsyhbiP3IBs43dj/vDU9NPxrO0acjencB3pm0iKw/fJuFpU73LZs8q7gIUKw
	 d5PqtFQKx3odsE3cj8dXpfBMoXNwlqJ/MkMQ/2as+O/balVEfgPFvyE4/4z60cxYqROKh
	 XRX2kR7gF3PSi//he14I+bIBgaMt092URnkUFRFaFRdW2QdOoLEmtSm3IK2c4xpvvqQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793458935;
	bh=nknIhTQlaIhRAYJU3CB5jE7Z3He1Ku916GtW66yynDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zc0stV1NYFVbkCz1VQmzsD4zKwfkiPaza+N/Xsx90Mer2wcESkUMYChbzt41iElnz
	 P62SsinPM3CiiOBNDlvqvvy57Xi++0W0tG4QL9/p4zFJD3Zc+nu5WzIzdJ2PAnG9xg
	 rgBQKoF1NB7ljbNHkBTXmNkKbvr8r2haueKk+eUVwsVAfA28l/ToES2oj/5yIeXk85
	 DOetbHIMw7lB+8IdRUg8HAtlHNjKbqKobI0OYAMAKfyOTdChLw4TVLIb4fUM4G069t
	 xYAJUc0q70YXBKeSB3t4m4k5XbQbN5E0Ldr4y8kMpiMKuuar2rrwy+yyQfccpTQe+v
	 K5ds2YCoNF8hg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0A17C40441;
	Sat, 31 Oct 2026 15:02:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 17B43411
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 15:02:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 08E3660618
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 15:02:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yNRAFmEPS67n for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 15:02:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 529FF60615
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::122e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793458933;
 b=jV71IxRBYNtMpX2J+7UIewgPNJ/c0R8S6UIf51G4QjxhM4BvK5VVD6wC59TVOgIr5i9F
 H6z+iD5B5h2h3ZuFWpp0MskINl1MGFhexFuaEF1vNAFbYj5yybFzjXhsKiuppqf0RQC0C
 7bLssIao359JHT9qsMlYUJjvAHLQZpB4jYO4YpgXKRhluhYxQGP0DmYjKz+BIPU4gJsHH
 K9Tny7qDCHAupURpMh9NmzjHDvozz5ABDC1FDSzuxB5ToQdULkM4MnJIK/KuNGtpgpKRI
 g5HdS1dohyJCH5eOx9G8QMVUWQGAdQ0nLQZEiReIlYucaEhKX+HlozOdZC1F+cJwYgg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793458933;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=nknIhTQlaIhRAYJU3CB5jE7Z3He1Ku916GtW66yynDM=;
 b=sS1Y1g1hTR34f9CPdpmD/EmWYGZgPYZJrKD3vhLo5KG/IqktKfRh1yu3e3KhUs2TRphD
 LiCTqwLjqkB8NT45dRUWbtlgaXSmqmWKKx0XkVxBAbSOUTbOwzFKQGOpFaH/ZvMCgdJq2
 7qh9WaMh77bHGf6eEinBnLCfL7c1nF8cZb10SQiOnq+NQ2cYrbgT87wZkYBTZ71dU7QZA
 N+iGFmX2e9pgbsEQvvjaQx79pEYacqI6xt387ebfUGIo/mhiof79MRUS4sZ+SoaOzcvsc
 7b1GKve+FWLY9UsNFzAJaBAtU0CcQN3G0vlMkIYYB+JAO6nQmOVK+ACGofk67TaSaAA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=RkQPBGl0; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::122e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::122e; helo=mail-dl1-x122e.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=RkQPBGl0
Received: from mail-dl1-x122e.google.com (mail-dl1-x122e.google.com
 [IPv6:2607:f8b0:4864:20::122e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 529FF60615
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 15:02:12 +0000 (UTC)
Received: by mail-dl1-x122e.google.com with SMTP id
 a92af1059eb24-1aefd1bf74aso457505c88.1
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793458932; x=1794063732;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nknIhTQlaIhRAYJU3CB5jE7Z3He1Ku916GtW66yynDM=;
 b=RkQPBGl0txJ7SnZHUf+xnJUGafokF3DftYPA+2OJQhluAF3GavWeNsmsJwQ6Rkyy9N
 iyAPWGzVciiIJHeFjJjQAwng7j955kMu/N/lwp0HQNimnNGeSOU0U2Q1DNcaGVJhzxrv
 Ku2yCOF2XdY5yp5rq+mHDWfZd2JEaOmIPnoE9VqvdLHc8IJZ2EIzcVpdjUiYlF1XGetp
 IVLpr9zlrJ+UVmYsGm1MuhmNBc1DwOgfQN4xgvYOGDyVoSpab3MqXdR81bKTf6fEGx12
 zTziWuQ8pfJyJvLwAUWfRslKRWvXnapzZg3Rxp6Vq6XdcgCZWGI+3fwjM4jRIYCZOf1u
 +qZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793458932; x=1794063732;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nknIhTQlaIhRAYJU3CB5jE7Z3He1Ku916GtW66yynDM=;
 b=LDiR8uX0hDWKCX8Bw31jjXUW0/OGeLkMgp5JiMxKEzIN9ZPC1uErfHjyidQp1axpS8
 j1OwYlT5vKGMnChlU1l9j/xppYVrw9R7W1ufVj2ZA88I1GFMSK5R7evuTZWUONCpGpx0
 zUep/KK9ebLCpHsrY2rlA0XiTyLnWf5W72BXLfRnrFuT48declcoeqzMla+j2/n9g8qN
 aGObfb6keENBTbrFW9N5Rf2xhFa71VedE+UTJ6BZsnys4u7G0MZUQIUWxGTmiyFP4hAz
 WjHxxohGoSY9lCSgemEgt5OG1ykAhvHK6QpzUt0jIPDMceRcZxoxkkvOs4rS9LW1Y8+9
 MJdw==
X-Gm-Message-State: AFq9FYLF/VcvTJ5LzMTuLI4bmhq3H/rfpUy7wbqQLDYypAyWSJ3egHKH
 KlSeBmDjno+kuwcynebpOT8RAY8QOsep/Z7InWzLJKUWQylUuNmBtX5d
X-Gm-Gg: AYBFou1wG0Rc316kZTTLWXiwKF9nUCgdhA9K3YGqwVZa3O2E8H3gioXMBE3tE3kxMsl
 7Tb7Yu8Yse7RmdR+kwA4GIGL56+tbKmtdXFmfYEGqEU4tOw/fEL8vBRMWbVGDA3MtlOPRKikexE
 HXtzr2BXmhlrxKKQFM6LwaKw84/wab7q8I9tlF0kNSU8wjfHZFrEAcSXzT3c+GN5KNGIG1XM0kB
 AFE1Jn25WlO/55za+6qRZ13J9hCAZxu9BtUStNBGoASAgRkUwBPYkZx+wQovWEOA7yesyAHGwl9
 lEjxb13/uGhN1y1eBEIfpGJq0PnRlE8XKEmKakYqcMbqI3j+Pvw+eGjYw2EOYdoeowxqSFMztCa
 4lPQkJ07ps5sezPw9NcjHfJOTHbsDXbYd42wYD98kGiPq2WxVv7eudUBChm6AnLm6vcixLYXAU1
 wQHAcQjSmzjpl3//r4UI3QsljdF8Totb6Dv7w/LKe021gueUG0UynkgrvLB29YDnjKmfcqSZ1MM
 pXW2oALNbJiS4gVMkey+2KwyyibYkz+u2XXhMF8rkcchrLwQqxjrxGdly/E3sF2q1RNQcM2KsZa
 Rd7uMjfaCeAwdJpj5MFlHhCybVJRDrp9cZVX1F0EpRnVEJBqsxJ8320ZaI2eDDWQow2vwVfnoRl
 ZXqfbdJJhatVzBQve7jrQMH/Hmsd8G4sNRPhVwVIxBt9wP0OTnCVRUwfmlZYhMQbxF1uEMKD39M
 I4iIcwtFTxZet6Yib2nOWLydorVriMIQ==
X-Received: by 2002:a05:701b:4286:20b0:152:dd1b:4fa7 with SMTP id
 a92af1059eb24-1ac5bda456bmr7466260c88.19.1793458931762; 
 Sat, 31 Oct 2026 08:02:11 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac13ef1d4dsm15477497c88.3.2026.10.31.08.02.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 08:02:10 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org, bmeng.cn@gmail.com, trini@konsulko.com,
 visitorckw@gmail.com, xypron.glpk@gmx.de
Subject: [PATCH] doc: virtio: Explain how to reach the virtio RTC
Date: Sat, 31 Oct 2026 23:02:07 +0800
Message-ID: <20261031150207.3315527-1-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261028102343.1747940-1-alan.tseng.cs@gmail.com>
References: <20261028102343.1747940-1-alan.tseng.cs@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The date command only uses RTC sequence 0. On the ARM and RISC-V virt
machines that is the PL031 or Goldfish RTC, so date never reads the
virtio RTC unless that driver is disabled. rtc dev does not help, as
rtc read reads raw registers, which the virtio RTC does not have.

Say this in the virtio documentation, and that x86 needs DM_RTC.

Suggested-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
---
This is the follow-up Simon suggested on v5. It applies on top of the
v5 series.

In my reply to the v5 cover letter I said the doc would point to
"rtc dev" and "rtc read". That was wrong: "rtc dev 1" selects the
virtio RTC, but "rtc read" then fails with -ENOSYS, as the driver
has no register access.

 doc/develop/driver-model/virtio.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/doc/develop/driver-model/virtio.rst b/doc/develop/driver-model/virtio.rst
index 30df0e944..94d3dabbd 100644
--- a/doc/develop/driver-model/virtio.rst
+++ b/doc/develop/driver-model/virtio.rst
@@ -81,6 +81,14 @@ on QEMU ARM and x86, and v2.12.0+ on QEMU RISC-V.
 The VirtIO RTC device (``-device virtio-rtc-pci`` or
 ``-device virtio-rtc-device``) requires QEMU v11.1.0+.
 
+The ``date`` command only uses RTC sequence 0. The ARM and RISC-V ``virt``
+machines also have a PL031 or Goldfish RTC, which gets sequence 0, so
+``date`` reads the VirtIO RTC there only if ``CONFIG_RTC_PL031`` or
+``CONFIG_RTC_GOLDFISH`` is disabled. ``rtc list`` shows the sequence numbers.
+``rtc dev`` does not help, as ``rtc read`` reads raw registers, which the
+VirtIO RTC does not have. On x86, ``CONFIG_DM_RTC`` must be enabled for the
+driver to be built.
+
 Testing
 -------
 The following QEMU command line is used to get U-Boot up and running with
-- 
2.43.0

