Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E451C55164
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 17:21:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D8F4B81173;
	Thu, 30 Jul 2026 17:21:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G5zfpE40qsIv; Thu, 30 Jul 2026 17:21:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 26BF580DB4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785432068;
	bh=kgX66jQ6fJd2tDxZWfNlvQAZL+ieVe8OUUuXlVKOf08=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sJ6qJS1/xZnFoL0a+WinKZ54FSSVPq3CMki9yRq9eKcIgxmj6CXBuUG8p7R/4UGib
	 rqyVM0/anGfLE+9/cIdrn5NLTj71ddpyp0YUsTHuwc8GTIsKpUqACK1jPrVEzfAtu0
	 4aojHZjAIk1Fpy5WHW7tHSPYhpmOrs3ibRQZjw5F239RouQt7fjkLYAPr04uCvhulD
	 PYnQC554nLp2fsHdMvQK5HGR/SfMcIacv/Ph5ExNUH7TZ8b3JhIZft9p3FyO8mTgoy
	 HFPGaOr6XEvonBIYHHbwDUfRGZqXWUpk1Ew1sA1jJoxnBqFDlMWU0lnffELQC+JAbu
	 kzoJ9zEnOvldQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 26BF580DB4;
	Thu, 30 Jul 2026 17:21:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 35428352
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 17:21:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 272E760A56
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 17:21:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h99NQeKyargG for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 17:21:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c30; helo=mail-oo1-xc30.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org C77EF60A54
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C77EF60A54
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C77EF60A54
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 17:21:04 +0000 (UTC)
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-6aae384221fso1424062eaf.0
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 10:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785432063; x=1786036863;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kgX66jQ6fJd2tDxZWfNlvQAZL+ieVe8OUUuXlVKOf08=;
 b=dWvogi+Te7lsiw/9cNYVJsf/3z1HHG/dOmfhzCeqGm2Qwl7m5P6GSNU9WcENt2NTJf
 eQhEQxLmmgFO49uBhFockkPyjeNVLi4G1HkNtF31Cut52m3y5ERgvlndqTtkCxPAmfg7
 prArFk7m1l3Jhrl4nQ835l/MSSP4ZlWrwt/Vwyf3BZaNJv6KICFQMYAVp7lnomSAYN96
 0XFT+iJ40fpUrbtSpbiovJ0c2L+px2AulUdj6NDLbVtNJ+oq0w0A/C2ZOFS550YaUVQ0
 lsXax713R/sBns7opzVSU87scZT9uai8CQGfPwYmdQQUVgZxAEdm903Rt7XlHLXMqLZD
 ehnw==
X-Forwarded-Encrypted: i=1;
 AHgh+RobJmZF9Ojdhl/cBwQ8FkLRlt7VwpPXC17KWz/JJA+nBqIHJVerLPGhb6/FRRzhglI9dO/y7M4=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YztcSNNKVXOc2r3ekllkcIF16RSZwX9NitXUUl2fciQmMTW3zoL
 LU+bPiZtoYPcSxQFa/cGWWcIt3fyDs9JYF8Lmo5pAtqn78fAjPjcXYWfcVQoyVMe720za1NADFB
 P33s5jOk=
X-Gm-Gg: AR+sD11Kt9M4Gy5OmCGqOqAouhG4m889X/2tN/K8MFLEIoJIEkgwREHSt7fA+hIvnaF
 SqfKznTGvYVlJGiu6irC/r5Av/pgAw1GQd72kp37FmqkP2TrQP+K1i6NLX2ZCgdxUmWFZ3VDikn
 UfclPvZXqtsaRd1BwJh7+cLk91VXTAfsIWKvj9AkJgtzY39WpjHGmY6hkI5X2oHf7eR6K2hjZ88
 b2FBLP11fNKlgP2v/SeQkZ1tayLIvvCoQyr1E7UtnA3F1rCQi/sXBaEeZMRJZYZesDrQp71DCaT
 p5OAhdTNv5Ci1uis/wNR5x6w3AYZqPsUWic68qbuJnrOH8RCr9j+RZVzku6FWtqvEEqF7qUAU3D
 MpsUs1Qe/l4tJo+7oFLSqvw27UA74lHCor4yBDhW5KCcYgHckUQTbGFhuNW3GxykMNZaFDYxgvt
 8DjxrkjT66Ari1y/3zxrWmvucSHbOf9bm9QjKuHlzSPuOZsufuT1iEM9Z6Rue/qUE8MMOm4k2bg
 QS6q9ncyn5p4iHOfBy/cimm9tS/qXtlRnNDgzLuEe7h0kIL9PAcwxI1MytF8+MBR4zdxH/48wH1
 jDM86cFG
X-Received: by 2002:a05:6820:81cc:b0:6aa:ddf8:f17f with SMTP id
 006d021491bc7-6acbbdacd2bmr2208445eaf.23.1785432063651; 
 Thu, 30 Jul 2026 10:21:03 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-458c2572bd3sm2348019fac.3.2026.07.30.10.21.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 10:21:02 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: eric.chung@riscstar.com, marek.vasut+renesas@mailbox.org, 
 jh80.chung@samsung.com, krzysztof@kd-solutions.pl, 
 u-boot@lists.u-boot-project.org
In-Reply-To: <amq08FNgmArMwuRr@nxa18884-linux-1.ap.freescale.net>
References: <amq08FNgmArMwuRr@nxa18884-linux-1.ap.freescale.net>
Subject: Re: [GIT PULL] Please pull mmc-for-2026.10-rc2
Message-Id: <178543206168.2224200.129259733668460399.b4-ty@konsulko.com>
Date: Thu, 30 Jul 2026 11:21:01 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1785432063; x=1786036863;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kgX66jQ6fJd2tDxZWfNlvQAZL+ieVe8OUUuXlVKOf08=;
 b=uAMRYFujSOOt+niYdhLk9RvVmMr7Vx1ylaDNTgIZURjSSNkKR7SgFdc1kx/PgDJGZU
 y2cJHFaUHhq94DZDqHWinFsFwmvDfm6t3ha6jqWYFWve9cvs4u4eztbcbVJUv21WW5Nl
 P6WY1Al63dLqPqiEngX4viZvRZq9iFxpfKIWk=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=uAMRYFuj
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

On Thu, 30 Jul 2026 10:20:32 +0800, Peng Fan wrote:

> Please pull mmc-for-2026.10-rc2
> 
> ----------------------------------------------
> Enable MMC CMD23 for multi-block transfers
> Various fixes to mmc core
> Add PF9453 pmic/regulator driver
> Support SCP 4.36 map for renesas-r8a78000
> ----------------------------------------------
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


