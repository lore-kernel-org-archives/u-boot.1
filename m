Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29D0606A31C
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 16:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=AZMtkRti;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=FOyCHZhe
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 77A8540849;
	Mon,  9 Nov 2026 16:22:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sP-E9MNNBzNw; Mon,  9 Nov 2026 16:22:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CDE64407C4
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794241327;
	b=MRg+5db+/xJflL45+RDRHKJxuzCy1BRpx2JCgTzMg2HGIztu2Eh1ngEyxzB90jtYyPsS
	 g2w/nJjkhz0ddaq59TbcnWwMbsJxQA2T3/stYOwwWZ4/NpstG1yDF+jht9rw4VKxIfzF4
	 +l9VBc6PlacnnSFgjczk1iTu1ARvGT0JREBG2iptu/tFDYOoSloCvG1TjCQkknSBXZ4Qw
	 Us9TN9cuNHaKSODUjjvkrFe7g3XNfLkhvIeF/heFsAVsWZZdnoSL+INiA58/vDOkJgeG0
	 XUR2YXPZS9h5BSt3MlnvvJFkSoXMEw5Ex3+UP6bwlFuxpVifhL9HP6YQWR8hGg2kO+g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794241327;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=UN0msUC/ASMKpHFPCdVGQ6CwWLXkeKktOCmFqxrvop8=;
	b=ApO4/yn9GImj74EKIvwhCjAkM67tFdBnJ4/GB/RAIwPuCkMRXhefSp2AtOdSkP4jdQHW
	 cBHS3JQi9kQGuliqF0jTCFmKtF1W3D7vitj1gP/HMJuW4VipLKYAnA9jAmyT+ineuzmbp
	 mToH9e1vb873e9FV4mq/tAkmt7ulr5UjrmMHiwL2uAyPTf8n5xlh4UAwo5bwPnVHL6h7T
	 r3XsqIioTk1xe0xyQ5LTKCqyewq+g8Jovsd4GLiKqk7Q9dfHtObi4XZniFF8tATyhwrAC
	 F+VnFEUoaWQnl9zAX4Y2jlwKUVu3+dwAbcDiwGNM8vAxojVvvUT+b6CTwhWg+PWV/Xg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=FOyCHZhe;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794241327;
	bh=UN0msUC/ASMKpHFPCdVGQ6CwWLXkeKktOCmFqxrvop8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AZMtkRtirFXNluC2o5x2sKW+S2ARI9v0dCLsSYmRN7Gr5jw18uzTfr7lJoDSdPZ2Z
	 nzZ1Ho9BJFsdWAtFDvNwwmsNIzL06m9eeNsqWkwPSwyaHJdGWg8bk3u+4C8sYBvWSj
	 JqmBPtUrIBtTRc3MRVSe4Wnx3Dor76lBVKGBAQaZfuDYIJZLso13+JOsLaDM+QgDp8
	 d5JGg0YQ2La4KwtZTZu4q1re4NjW6WSGpSBScRpAaCoCb0XDNL2A8UVb7nLTGtJBYJ
	 MWtqoKMtAySoAZaYlnc7qf64hzstGFrX00KPLbu1A6rHEM2fBpn/fiOj/KL7Ff5bJ2
	 TH8r46w6tPHlw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CDE64407C4;
	Mon,  9 Nov 2026 16:22:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C850D362
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 16:22:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BA344407C4
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 16:22:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LOnvsEszm8j8 for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 16:22:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1995C40730
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2a; helo=mail-oo1-xc2a.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=FOyCHZhe
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1995C40730
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 16:22:03 +0000 (UTC)
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-6df5e315bd1so759750eaf.2
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 08:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794241323; x=1794846123;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UN0msUC/ASMKpHFPCdVGQ6CwWLXkeKktOCmFqxrvop8=;
 b=FOyCHZherIwvK4I+t3GUM6GC09JJoSbryWKvT0tT0nm+TnppiejqsyKC94iwil4E0K
 ajj3HmAbgcAN7KSpBIPsz4pXSefoFk5OL4CEYFK0o4CQ4Ise40M0QYnQ14mwF9z7pP7a
 4s3uPXHUPVGnpUBKfV6hObcnQIJPjzUQWqYRRNxfQR0PgiROMCV5zzbTi8X4+6rdyMkJ
 m+mL1r853xBroZYvS9YeMyJ5FI2M/XF4Xe/y7Ql1/B3iYO4RWLEaS+L5Z9ctYxV9Ai4g
 AjoaIn1X5nOZ2J985onqkHBcOnz8gHSXhOqHxEAb5HXjeUfzSDkyuHYAKnWVdYuhd7V6
 P42w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794241323; x=1794846123;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UN0msUC/ASMKpHFPCdVGQ6CwWLXkeKktOCmFqxrvop8=;
 b=zOwlli/LPG8L4LnUm1t6CubfWhKjGijVitfweaIMeTkvSd16ctJF0IUxN455DBC4EN
 0LrF0YyOFrW6gdW/lDkdKna+4wzT4CS1vAGa8FmvC0e13PkL2pV3gOiGKLaxzYMoSqhx
 pKCW+pJE/wwRC31aN8B+HzmQOpHDIZgPuIRFWZOOPqygEK3du/m3PKx+89A//D8hHb05
 uQBKEwX7RxyjRdHaekoZfECuMpBsAZDKG104Ff6dtADN+Bwxvav1Wi36sDPWr6jTjdxW
 mMdJ1h0fTwTpaBUhgjN7O6HziyC8SA21DJdUSBEKXxMbr3gfKJyB2wYqE9Rvsw5zBen0
 fgYQ==
X-Gm-Message-State: APuU4Z937Rt2bYd2uHcA6RxhwYJBWH01u+dPaGsSiliLqwE3It+oAcDY
 MW/AeFVbiGaHImbX5aWyxk2SJYn7ASVYzYWEQCBFJ21/TEOmnPZQbe0btw5+jgXb03I=
X-Gm-Gg: AYBFou13UUqqiSc9C7mJpZBFJhCTGhBuEy9aFX9JXgS5QPsHrkVclTtk7jiA/no/bAf
 GH2pO5QwEehBV0Xx+UbBehDa7pZL7kEmPpwXYt8GVtc7tqLgr49GhTAPrnlcfZpL+3uRzjfskBf
 2bx4hc+UBe/+HGdUJ0BftKz/Nnh4O0RAafIN5FZCyB15vX0usm6nZ0o2rMTwk3QyC5qxghlwi8p
 UiSnxsXQqCnvZQo2l4vabH2ghpD1OBYJNuxtnfge25+VySqCmhqJTuh0Dkpc3I4FQvTBPKQvMl2
 Qapy7I01+I0bStq3+FNjoeIbaBguvPJenFJm8YzMNSS0Hq4V26CjPhFrxBYRa16/F8sRZTL6L9Z
 Tjz7GrU6K/HIzGkJTqsMD/3xEi6ViZmvDSMecIRmSDsibzumwgMhUrpEL+eFTIfPYckft0zvgpc
 ROSoBPZywvfB4WLZGvcVlkee2RcWwx+qiVliflTseS/uA22pzFU2WqcdtblXbb1qlHMSI16EpTU
 V/vL+dhNQVHlf9g9mvetsH87u+XCdvDURIbj3OUhlWn0mlIngCVpLe9t0esbCCJt2uagML9cAKc
 0Eel9f84aSVCLeWlozhhiW4Bno32MCzhYg==
X-Received: by 2002:a05:6820:f005:b0:708:ec28:6fd1 with SMTP id
 006d021491bc7-7170f2ea251mr2265160eaf.66.1794241322674; 
 Mon, 09 Nov 2026 08:22:02 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:e08c:f307:ba9d:b979])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-7170f7ea062sm3673411eaf.2.2026.11.09.08.22.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 08:22:01 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: u-boot@lists.u-boot-project.org, trini@konsulko.com, 
 ryder.lee@mediatek.com, weijie.gao@mediatek.com, chunfeng.yun@mediatek.com, 
 igor.belwon@mentallysanemainliners.org, jstephan@baylibre.com, 
 GSS_MTK_Uboot_upstream@mediatek.com, "Lucien.Jheng" <lucienzx159@gmail.com>
Cc: frank-w@public-files.de, daniel@makrotopia.org
In-Reply-To: <20261012162656.6918-1-lucienzx159@gmail.com>
References: <20261012162656.6918-1-lucienzx159@gmail.com>
Subject: Re: [PATCH v1] clk: mediatek: mt7986: drop duplicate dt-bindings
 header
Message-Id: <179424131224.3924283.6096283416578811621.b4-ty@b4>
Date: Mon, 09 Nov 2026 10:21:52 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=341; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=yNlzGQoS97eEpq/BQvZaXmOEHE9Beqg6y0DVoBuXW3Y=; 
 b=owGbwMvMwMV46IwC43/G/gOMp9WSGLI+flaMZ/9trD3RtP+7AOPkywVba78+22PfcPIrp1zeX
 ME8G22lTkYvFgZGLgYTMUWWNxI35yXxNV+bcyNjBswgViaQKWIyKTmpyRl5qUUOSYmVOZlJRal6
 yfm5DFycAjCFjhXs/4ME2TyMGI8UsLzSjVkT5LH2MSOjnPpkC9+E9E0BOtImTO/Sl67a3h7WWsu
 gXdh8IeS0w0bdE148E/tv93hOqau5za/3ZyV/4qzZtqXeMlOULZR6Q5Xveixf/6PiYoLATvNVf9
 +cic4pmGGQI/vo/Qz7ruu/ePe8YY5/bcG000k7aerC5KO2pvtkTf7LOrfck+nbv+bWnujHQnaZ8
 pZnPofuvPc1OFFRWCotIq3z4Te+6GN+z0s0HO/+V5GIe2p4VMfb0Dxk9xnhZeEXel7ZGk9b07Mw
 OaOmO2p/kdF23ml5i7c6rBWXlz9Sp5ygI7i7TmNO+55s46rVzkcv6e7ikBQO1IoT1+OtfDJdqBw A
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 13 Oct 2026 00:26:56 +0800, Lucien.Jheng wrote:
> clk: mediatek: mt7986: drop duplicate dt-bindings header

Applied to mediatek-for-next, thanks!

[1/1] clk: mediatek: mt7986: drop duplicate dt-bindings header
      commit: 1d7b1f28d30b7059aaf0e473e179cbc8e7718efe

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

