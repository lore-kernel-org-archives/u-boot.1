Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0797C5CFC1
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 13:51:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BB0E240DAA;
	Fri, 14 Aug 2026 13:51:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4gryqdyqJ8TH; Fri, 14 Aug 2026 13:51:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BD1C840D83
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786715474;
	bh=PaylLZ6ISco9Bt3Qj7yBDuOjsj8yAtbRgS+BP9YTmow=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cvqH2fpdSgYNWQY2463CIAVFDwZ5s6JcMQRjo71Ptuf2UIeXpQFFDNkGrkmtWj5Yx
	 49GkeRtNUieTtWDzmAZc165b5vQdHrdHCiX+q4j+Rpl+QaFk+sUcrNcLK118E37TgL
	 orqLKh35nutJag9+4dPyXg4wS1EtfB5WOCNINrEhHG62IopSNFnn0ny2hZKCwxThm8
	 L/yxAtSbecQNkO3rnt5775o4HWKMRhugKNauCGuC6zC/G3lr6kNRRp9jJVG+r2Qp+f
	 fr0CDqWjgoZ76Ql6IUndWjbxG8RIo+eEEYNrx2+SuKEkjtoh6nnG7HSS/5OwyWKxuU
	 f77VHj6j8iaMw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BD1C840D83;
	Fri, 14 Aug 2026 13:51:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C48B6361
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 13:51:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B644860626
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 13:51:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QLqSEIAOC6DR for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 13:51:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32a; helo=mail-ot1-x32a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 6760A6060A
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6760A6060A
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=l1g7S1ug
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6760A6060A
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 13:51:10 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7eb61bbeb25so879374a34.1
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 06:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786715469; x=1787320269;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PaylLZ6ISco9Bt3Qj7yBDuOjsj8yAtbRgS+BP9YTmow=;
 b=l1g7S1ug7KYYXPToMH+TYYXDNMKEfEcpZd0s4COBTL71cFG3Bq/3Apxpo6vrLGEBCq
 AiUmADX61MFNElzKfqqaZZIZgqpldz1oYYKm36gczhxH6z5H/ilYgEQ2dp9hQoUphGr1
 A0qBFecH2qKwgFvOyxzE5OUI71MNO2SZyMhP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786715469; x=1787320269;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PaylLZ6ISco9Bt3Qj7yBDuOjsj8yAtbRgS+BP9YTmow=;
 b=C0N47O1SiKA2ZGkWiBNiEjZKkFwDI0mWu11NZT7o0U0Ucw7TnDK9uFMjGjPVf0pqUR
 uAHcbYGxQ8I6wvnIA1PqOAGd9znVR8KRAERRZdec5i4uSlDK740OZhAD6VSP1dDv0NgU
 SmDvThQPCqh47xzS5xDCzU2DFsGuL0/Pm46abUe9WMneMg9t7Fjkc3/i4Rb4YhhDx/t9
 bNuD4V6KJuGTQw2/D88pgQkipJ8c1DDp3GYepukBbPO8uSU0mDl+1lyvOZtK6cyrnIXi
 SKi6/eUbSNYlhLQLWLROuKv8RVKIEGPV+/Kn6yRhKApNM5X2jVsLmpZra2lyrlzFmffp
 sfbw==
X-Gm-Message-State: AOJu0Yzz9sAcC8taXwe7ku2g0hn9+QlQVE8PIPM2gnhoQ7ECOL/Eicm7
 zT6bWYeii3BxFsoLEL9P4bklu1WMdENTs3xB/g+5yH0tA2Up2OBQy2aUK2G3wHDyJBVCW8JSbhp
 Xezh4hpU=
X-Gm-Gg: AR+sD11jf7old0ivGA3u4MnZF6O7lfBrhFoGL2RzNmaRjxEuDFd+CvhmXet8I3AWQRw
 GyuY/Hplul09ILm0g0Qkr+6+28tZ4X5iclwkLnu4Zp6Bm6WMCs/Bz2At+UJ27ba5IPEFAw+cKVe
 FpeAGSIvN/RX70c005wJbe+vFN7RnjX8h8j66Fz98yGQ4IqghyCpQTe6XM+/zsd1b10WsndoLyQ
 AJsBkBigV9pEIOLI54z0U1Pr+z9Ow38t9BmIB96SYw4QbwjCLnEJS8zIsHEVLeeyhW/WXFh0DIB
 gBTQBg++fZMwRtqT7WHYLXkg4w14k/z/6xgi2r5ZjjveJcKfZFJMItnyHEn+kslSGnq054uk4jb
 spVm4D4Br04+Bq1vMKOA1e/1FdoizxnH1/3d+Hx+ZLbPF77HufQ+Xl3pTwBMo/E/C1TY5lTE3l9
 11UhfQZcNrsWIEiDubEIuS332d9sXpCr1DmvRl2fH7Ns1hqzkOZz/OND/ZSLLSXX2tC60+2Ik7p
 vJG0qqXJNcIARP17NZdt6N19gTpiP0K6sBNpEJ0VldQQ7rU7WJvyadE+BIF50Li386DKqe/QW7L
 QNEeo2ZI
X-Received: by 2002:a05:6830:668d:b0:7e9:e0f3:b914 with SMTP id
 46e09a7af769-7f3de68909emr5398723a34.13.1786715469155; 
 Fri, 14 Aug 2026 06:51:09 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f3e86a2271sm977086a34.27.2026.08.14.06.51.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 06:51:08 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Alexey Charkov <alchark@flipper.net>
Cc: Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260730-resetinfo-optional-v1-1-0b500903e4b3@flipper.net>
References: <20260730-resetinfo-optional-v1-1-0b500903e4b3@flipper.net>
Subject: Re: [PATCH] board_f: Make printing reset information optional
Message-Id: <178671546818.3828101.15354731915776310260.b4-ty@konsulko.com>
Date: Fri, 14 Aug 2026 07:51:08 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Thu, 30 Jul 2026 12:39:27 +0400, Alexey Charkov wrote:

> Current code tries to print information about the reset method whenever
> sysreset support is enabled. This causes the core to try to bind the
> sysreset device in board_init_f, even if the driver doesn't support
> reset status reporting, causing pure waste on some platforms (e.g. on
> Rockchip RK3576 it increases the boot time by ~0.4s even though the driver
> doesn't support reset status reporting).
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] board_f: Make printing reset information optional
      commit: a1f39f70134734c7e3f061900fa988d46771da44
-- 
Tom


