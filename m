Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F237C44536
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 16:50:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D00E83015;
	Wed, 21 Jan 2026 17:50:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PL2VxycX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11AF1839D5; Wed, 21 Jan 2026 17:38:50 +0100 (CET)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E236E80077
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 17:38:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=anandhakrishnansasidharan@gmail.com
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2a76f90872cso38405ad.3
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 08:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769013521; x=1769618321; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xFRNDK7dd3OEN2WcSOTQdJ6KShNOHoOzFnrIis4jAFk=;
 b=PL2VxycX+r0H9cJtp4GG0JDl92H6i1+7VxKdEA24ar41rgTLDR+tjbTYeagRn+88pr
 KeKSbgXq3++snG8i1nKjKZXwk5mAjw8kmD0NUFmKGIf5HHK/AwyLu0pWwPfjbq+jHG12
 2qa6TbsVpVHwZsUIU7aF9jawVTeoZyMS5Ak6vD2vLaZFH6kpN+bdFicwi2a5rbYMZ+s1
 i9YqMboS4zj+qgOjW51h2t9y4HVXkZH9kg69nZLEZhLYb+Fu6bTppulwvrdiM2X3vp9D
 ApZUt8Le0juIMDqu/Qh8x/7PCFB4LAvn/jsM7qylI2AVvLO0SEWo7UmeeA3ajAC63jRP
 FJ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769013521; x=1769618321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xFRNDK7dd3OEN2WcSOTQdJ6KShNOHoOzFnrIis4jAFk=;
 b=rgdj7AXCvhClYWwaBkdFn5M3XoMxoc9VuAZd3C9Sqp3AHjtwzYFoKDjDu3iW2P7+sE
 dPzLYj5NJUIjSYu+22fknC+7eOIHBQi4RBUYzpWDWm5/DpUDJ/v78fQ7CGzCm8hPTJD4
 xkJcCopU//N6CJJr4z0Ui9zeX7zKpAVGwa9RYGRl1hpG4KdBo3enDyABAOt9E4tngnUd
 9tOtlJ6y54Ip5k64/bBWnd/xOE/cEUjfBpzw93HYHcsmf0xUgAS6p8IB5c+QZB6kt8eT
 oxhBZnhQf50pto9sM2ghh049wGlqVHH0U//PvgdlO6H2yAiFPP/WidKK8gE9AJ9r7LRG
 AZsg==
X-Gm-Message-State: AOJu0YyOI4VtBtEaNakiuRR0E8dNs5plG6i9TesE68cArUA4ROr+SFTb
 QI19zGplA1eR/JsK7Z7E50zELeNwl2lL6IXKKrHT3AqT3oOWPqFj2qmMqKLzLg==
X-Gm-Gg: AZuq6aKADpEa5gPeJvuYyt+7wlZsgLxX/nhovFBxmb98nHSIO3roThG6Y9YGA3ccBya
 IX9w2zb32hDbRjBqwG5oLVizOrDrMjA5trgYHkO8PSE8QFVa8xzCBngjVoYI51HNju/NIE3aPNj
 IJ/ATaz98404t7iTyjkfIN+OhhH0Eg2eidT9N8+dj+hWlzsoWJHFuZh9hVjHKQTbbGZ+lqF+Weo
 ERNlRJ3gNmEUbQZ/J5VpGbtQ1HtFx/hI4k6jseBg5GFMOKBw/r/s+7731CU0NiaQDRD1VTBZaQm
 ef6ZUTkkPB2UJSyw9gnfTvFNk/erfXo35L6JoUwkXA8UY7JxYbFNtKbr3YRvdNvANx7s5Y8MiqV
 7qgqwMisJlbsbWUXMRzxjxKkz1Msk4SmNHpKJTDCSlq3zpwaPbPxkM0eQqV7o4GwwAG0NdI8xkV
 0W7EeT9QaF4hTnUD+izkD295HUHZdh8vVMQDbbK/gY
X-Received: by 2002:a17:903:2a84:b0:295:96bc:868c with SMTP id
 d9443c01a7336-2a71885a28emr204150995ad.5.1769013520970; 
 Wed, 21 Jan 2026 08:38:40 -0800 (PST)
Received: from localhost.localdomain ([115.245.213.202])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c5edf354b24sm14889122a12.28.2026.01.21.08.38.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 08:38:40 -0800 (PST)
From: ANANDHAKRISHNAN S <anandhakrishnansasidharan@gmail.com>
X-Google-Original-From: ANANDHAKRISHNAN S <anandhakrishnan.s@dicortech.com>
To: u-boot@lists.denx.de
Cc: bmeng.cn@gmail.com, marex@denx.de, trini@konsulko.com,
 mkorpershoek@kernel.org,
 ANANDHAKRISHNAN S <anandhakrishnan.s@dicortech.com>
Subject: Re: [PATCH v2] usb: xhci: fix DMA address corruption in abort_td
Date: Wed, 21 Jan 2026 22:08:23 +0530
Message-Id: <20260121163823.530612-1-anandhakrishnan.s@dicortech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260120145055.233298-1-anandhakrishnan.s@dicortech.com>
References: <20260120145055.233298-1-anandhakrishnan.s@dicortech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 21 Jan 2026 17:50:24 +0100
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

>Can addr actually ever have bit(0) set ? If not, addr & ~0x1ULL is not
>needed and you can literally addr = xhci_trb_virt_to_dma(ring->enq_seg,
>ring->enqueue) | ring->cycle_state;

You're right. The address is guaranteed to be aligned and bit(0) will always 
be 0. I'll remove the redundant masking and send a v3 with the simplified logic.

Thanks,
Anandhakrishnan S
