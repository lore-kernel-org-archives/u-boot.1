Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B4ADE7DF0C
	for <u-boot@archiver.kernel.org>; Mon,  2 Feb 2026 16:54:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2BEC83F14;
	Mon,  2 Feb 2026 17:54:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NHugBbZa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9648783AEE; Mon,  2 Feb 2026 17:54:37 +0100 (CET)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D90183EEF
 for <u-boot@lists.denx.de>; Mon,  2 Feb 2026 17:54:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-65e943048afso2058098eaf.0
 for <u-boot@lists.denx.de>; Mon, 02 Feb 2026 08:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770051273; x=1770656073; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fNsh9th+zVq+eJupQpoteR4Kc71Dvhx90SYMyd43jKQ=;
 b=NHugBbZaGzbIpcuYo+vGX+8yRm3/XdgbZSpjSmuwMXd+8WsFSBRydnJOrqQuuW1Lrj
 PScroagabmD8gx2Y6bXOKUZeSnMMzhu8W19xeI390JGEMhRpiTmhbPViZqLf3m2K36OQ
 dP2JVH5XMhphOq5dMLa2PiKPUOfXu+36Isu+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770051273; x=1770656073;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fNsh9th+zVq+eJupQpoteR4Kc71Dvhx90SYMyd43jKQ=;
 b=tgvQEBPVVzQe/ZO0NCwZqNKwTVcKNErYDPvOpKG5xlLG3AQ5id+ZnVN2MbpdcUtqJg
 flrOK6CvaxUxptv2THCksxrWl/baD9KC24dlVJCWfY57rMKwsqN0v6UiLhKuKGAWI3cx
 5mS+O+rVmxFJFgXrIioG8NQC0fRfFmJJ++rcFkqlaW7lO0xb4yLm//9Oid6VLoNT4q13
 Fhs002EYrBfI6AtktsXfFw46bxPfqKUV6pQILqYJUYoJ9+WtENYFmehe1D1c3dffDr1x
 39uXduz4oDta2i2WzFKzT/ZvPqNkPf6VQC7nGsqqe7/Jo8Cr5XdW+qjTjOwyyeqrCFAB
 lCfA==
X-Gm-Message-State: AOJu0YzCOdf6zvDXyLu3Zg+761JGq3ISP31vv+Znkrn9KXoUWKmc6ZRJ
 tYI/C9XiB6mKqryp7jd7n5LbKtwuyylm/HhRavU32L74m7b4WuavIXh6lz2dkgcuKAI=
X-Gm-Gg: AZuq6aLMDgk6tcvxs+6gZI3x5ePnIwj7nowiykyoCAKWr4L0EQctR7tGuV9Bj8peswc
 baZ0SzmjZgMMcdthmtqKgay58X+deq1hyAwdL6JU1EpBdYQ7XdSkmft+FWO06b78okGWU/W8wyN
 LFc0aJVokXImbuYTGO/mw6o2M/4vFftF+ac1QQwUkrM2XT+y5rZcJGEkCZAFsnGeJUPmu4QJFJX
 37+1rxruQEtlJSXtK2fRY61+Ze603kBq8VlNyVFIFiU+TqEVuACupIlPsVhH2Y2TluoElurV41R
 fsuLbIcnZPBByANH3AFRPhLHHxmJC5SkgdieOG5sXS2qIcClO2tCcXPbCTFK9DueLHds1KdOklG
 F26zfkYLlxEmWSm8iixs7G+kLIWJKTc08YmPyAdFu2mJC1JBoT/H+Ml1aJ+sb3M9Yo4vfg1csWa
 i9tntO2+HLdgkSTK5MuqtH8DHoivInmzR8U0v5HMtzxoOg5augdVKODYaMgGJq2AqEtpZ+L/s7m
 4K/n167Ra1QU77yHA/PJXgYQmv6+owBfD2FI+eEJ/W4YyrX
X-Received: by 2002:a05:6820:229d:b0:662:e066:7397 with SMTP id
 006d021491bc7-6630f401402mr5865512eaf.71.1770051273296; 
 Mon, 02 Feb 2026 08:54:33 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-66311d7e446sm5964901eaf.1.2026.02.02.08.54.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 08:54:32 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Anshul Dalal <anshuld@ti.com>, Aristo Chen <jj251510319013@gmail.com>, 
 Beleswar Padhi <b-padhi@ti.com>, Bryan Brattlof <bb@ti.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 Yannic Moog <y.moog@phytec.de>
In-Reply-To: <20260129035512.639362-1-marek.vasut+renesas@mailbox.org>
References: <20260129035512.639362-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] mkimage: fit: align DTs in external data to 8 Bytes by
 default
Message-Id: <177005127216.4027196.12034492055028566596.b4-ty@konsulko.com>
Date: Mon, 02 Feb 2026 10:54:32 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Thu, 29 Jan 2026 04:53:29 +0100, Marek Vasut wrote:

> Unless specified otherwise using the mkimage -B n option, align
> DTs in fitImage external data to 8 Bytes, and retain alignment
> of everything else to 4 Bytes. This should fulfill the DTspec
> requirement, that DTs must be placed at 8 Byte aligned addresses,
> even for DTs that are part of fitImage with external data. For
> fitImage with embedded data, there is nothing we can do, as the
> embedded data are aligned to 4 Bytes, just like any other DT
> property.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] mkimage: fit: align DTs in external data to 8 Bytes by default
      commit: 22129bf4733d78da046337440e85a9e49ca1a421
-- 
Tom


