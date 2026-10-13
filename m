Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50672CC6B08
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 14:20:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 004166073C;
	Tue, 13 Oct 2026 14:20:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KkSWVCjM2KlV; Tue, 13 Oct 2026 14:20:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 46DC360727
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791901203;
	b=oMJwt3RlR2j7iPPhd9SH80zAYF7W+GgZmHAQy1d94P2mAUY34t2e9vU7n6vxFMfcADdD
	 cv7rhqegb9MAPTysF4vcYbjoWVgGK+Cr7/LIPZuY8rmSM0n6beMtfgVC1kvNr9UjT7Mf8
	 rIb2G2wM5/8Yy69FwknQbmUaYp1+ulWFIWjWEbb7xIYTxYs2/GlHZclQcvuizqGQnpfTG
	 eU8KqDF+ukkcGwV0znICz5DzInjaGfD/tly2RoGhjy80ANQZ7nwyNMGC/x2omtQ5Peqnl
	 dXn9ux9vBv/15OiNOeDZRwNbxTuEbvIqKEy7nYoPhOCy0xN+/abD6YQVxqQ2TdfrqJw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791901203;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Z8ekv78kUsTH4Upw5WNX2PT6Vm4pp8li0NXMj3EPnx0=;
	b=WsjkC8rRN/VmPnOU9gB+NRjS1FLazsP3bo0Q6yoJYDqzoITNxn1NHcrYMhw+MhVuMvBS
	 8CMhoY1JmX8+oV+3WMvajZyfa3DDe3ZPqEz9cQUBIzXL2lVL1zluEvVTpFTD1TVD1eYbM
	 N9sYmBcHNGyHBRDDvgfMPaQ8Xy1ZqtwWCdCxTISxwaXLXfCxVf4yXuG+r0uClXVshIMrY
	 XKULS5BFW0HPZx5SChO2Gdeb9KbcU0AemEgLbx9YVzDgD0Q63zyZ0G4EzNy/LIh6E2HzH
	 9lR9j/IGZ8QFGXzk7y9gh6UryK+uSJbIpbD7pspmKaQoe6foAKUWiO2nYkIrY0sxD/Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791901203;
	bh=Z8ekv78kUsTH4Upw5WNX2PT6Vm4pp8li0NXMj3EPnx0=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xD/Y6XgKPS2t45COZEda5lMfiABi8UPHmyRkSQdAu5NKKn2rcmDgbWiNsLean5tdA
	 QlJaEmAOGdgGIo92BfjVOOOG7VwU4Y6uZBg1GLhWodagA4zNSTEY4KKgbIj8shp380
	 p1jZknZDrJzKjb1woevGhT3H/+RKNIzvI+KTV/bBq8+6KuaS+HhqBI/oqLOtRY+OSS
	 s4R0ffQ0avLN/AC16NFNZjUx+cCinyzoBlWJopr5AXP2uK8suO90AmjJrR1cFlDXqs
	 9i+eysWLXYahRx175RZ1aUmSBCgP+rbBoXxSA160E9oXny2BCHYFRA+VTgHMBBPz39
	 37nJrQjTdNGHg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 46DC360727;
	Tue, 13 Oct 2026 14:20:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8CF36788
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 14:20:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8A16980880
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 14:20:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z8XXjo86hyrs for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 14:20:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CBC648096F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791901201;
 b=AE+5F0aHeU4PBh+/+w6eVyfmDDVj0kzTggftXY46bVjG0bUqYbfy9Y6MtKnzWpEZjhrt
 /AI8rufehsYnCryLdrfToTi5ejLDIIV26kTE3/+dP9jRW1rhlI/0kwKdM3AbuIj522tWJ
 YyiKCIEyGkLzo7HLCk1wN43YwAVmag90aTfTnLXk63GneBmdaCh1qk7cv8WxmofX0Egkk
 trc29Z2xJHy85irCRag/e9PQ2a+Y7DuwIncyTSG/i2wDXUNdBziXWVtkyrbUiZUSLjeyb
 vQPmOr9N+mM7nPADOm6vFol6PS51qd1xxVGuEoSYF+Wvk75UJAoWRkti3Vh8jT690bg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791901201;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=Z8ekv78kUsTH4Upw5WNX2PT6Vm4pp8li0NXMj3EPnx0=;
 b=nUh7DxGQNHtojG25Ua2tIz/2tsq5mZIluJbGwZu0wuEwD/F5Npa8SF5HAkWvcbb/UD6G
 1NwtGyqBz10zOqxLXqkyqXGzamKCeg3dTVgawHa7WAhU65LCS65p4TA1zEEG4OH6pZXcL
 bs5ZMQknQnVavrpuupPlhtvVgqZX8LUM+OHNIJ6meLMzexg4rz9AWk4QdJZokvZj8ed+W
 ESO8wM6nhWaecOXnbd0DoUGSLq/LnQkLVYbRWucANBx8AGneTgfbovN42pcLO1CEPoz8p
 gJ7sSN+gIiI3Xkfj2L2IrPirtPjBzoOcYiYjIQK5htMq2DFfITFlLB4KCGIdZ6zHMfg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=ca9jLGo3; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=ca9jLGo3
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CBC648096F
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 14:19:58 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so20177505e9.2
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 07:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791901197; x=1792505997;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Z8ekv78kUsTH4Upw5WNX2PT6Vm4pp8li0NXMj3EPnx0=;
 b=ca9jLGo35N6QN9iApaPCS85VHipviZcoTfgkqDmV9N7bnHfaxpuZARGaxwTGtb5i+t
 GuTngFFzYGlVWAw1F2tl6+Ch99LitWBCeVy+s8v10xv0CEMCedC9U4gspIBD/VRMjwjl
 j3hnAKF0A3iL1iYIurnjBB0stEMBaa2DMwTCVFmMFtcLFQkpL4e9jQySbV6VH2inS65z
 dwW+Ll0oqpnk0P2df8h1oj5cadFRmhFMMpSHNNgFn13P3JAClpCUEPJkGwEtzqbQq5Zt
 oMWw3Ok2QtZe0kfxZCl0BT8DKVPOXf0QQr4f8QGWhRdy+kslR+Zz3DtGwz8KTF9Es9Kt
 vb2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791901197; x=1792505997;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Z8ekv78kUsTH4Upw5WNX2PT6Vm4pp8li0NXMj3EPnx0=;
 b=I6yLaN/2WV/pvb4NRRKPIFW5ESvfzGLxuZ0iubz9VRKCEb4VatiAW0/kauK89224Pc
 P7yVWWHg9crLn/BNl3375ZtNdehgJp3Rc7MVoSPg24TzedZrQch5as5W1tKEbHKsPxuQ
 M7Ic1aOb1jJnUIexBKmoItsqwESKUZnNCexqVi5518TGRvftoZ6yGl8IgHMEml+QBYon
 DyI4XcutQX9XhB/j1TogUNUdJjPEf3fWSKcnj3Apf6plDkiRSrRJF6bod+prTpy9Bhun
 ERK0QfLZVvUc/diI/JyI0pkrgA42+YzHxSB0coDltlxApEAIERrRP/T23YQ03/2nzFXK
 W5ww==
X-Forwarded-Encrypted: i=1;
 AKwUvBw5ybf+CpqIF4JeCTcgnkVES90JT+xeziXpgKnPee4TtcNo8Y42Jiwbte8es+cqPheaJogrDio=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYK8Wwdx9IQT4UkHAGciFuzkFzxmFMxiRAKtV77rJixkgJMH6kwO
 LldXNQuWMO6fZdasJQa6mbum/e3KTBya4cakHR39UJwxQ8Q+aCO/ReOXdczPKaGjltk=
X-Gm-Gg: AYBFou0OO8MjhIgM3nC2I5N2SvVC50uf70hr6mJqh3Pjs/bN2Sb3Es8NToWa+Ui2mg2
 FipMZ+d5V+yASkGOMFMjNSedJiJ5zARet+IY7LUnLd8MO0o1s4plmEH+VhdEr84y/pF/IGmmeDW
 2p/8EjJ1m4pwakokybdzMR2NJtD/quu485ytbp2eyIiQJxiiFEG1BdUGseIdBbdCGXOBrFB26UW
 cTNKbqkW5XuM/GWQKTgdczKc5zQioO8TT0psXYCQlP2FCAgKSZwL1bAjnvgdTGvN10pOaduAaQB
 VxW8TIShEsia9wm8hgrYYrHRI5MBWspmC5x/ilIh7cHXMZlTMs2xGrHqmMz5emMuPiAANA3XUIv
 nNKpFlU6ZA8mxBApkSc+CNe6TJpllOa+sE5NQPfAAMW3ppdUdYp1B/lL6NLlhhLosWACBkGiDZD
 dB61g3OZAu46Rjs2tODVWScloHaVSVuP/9CVKAtovBKNEIFkDo3hwD5QUc5Lh1KJhGzrUcWdmtH
 /lSklvzBCkl2IpuBKJZq4av4P+QUHEXEPiRsgrs3tJVW0mHlq0GJS6+Azgk2laBrpkExMCvzB34
 PvUhywpkh0W/DwT1Tvm/gz13YxoHtigno/RU800TA4fQfUAbbVyWnTs=
X-Received: by 2002:a05:600c:818d:b0:4a1:6c79:fd31 with SMTP id
 5b1f17b1804b1-4a18e483231mr240613085e9.12.1791901196780; 
 Tue, 13 Oct 2026 07:19:56 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-8434-7c41-c701-8278-849f-666b-c282.rev.sfr.net.
 [2a02:8434:7c41:c701:8278:849f:666b:c282])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bb6b3cbsm293801535e9.0.2026.10.13.07.19.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 07:19:56 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] clk: mediatek: drop unused fdivs_offs from apmixed
 trees
From: Julien Stephan <jstephan@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Lukasz Majewski <lukma@nabladev.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, "Lucien.Jheng" <lucienzx159@gmail.com>, 
 u-boot@lists.u-boot-project.org
In-Reply-To: <20261012-clk-mediatek-apmixed-fdivs-offs-v2-1-683cbab13829@baylibre.com>
References: <20261012-clk-mediatek-apmixed-fdivs-offs-v2-1-683cbab13829@baylibre.com>
Date: Tue, 13 Oct 2026 16:20:03 +0200
Message-Id: <179190120309.53105.9242791752776982931.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1791901215; l=646;
 i=jstephan@baylibre.com; h=from:subject:message-id;
 bh=42Fm/WWdeDLQBdmaNnhgnGRaM3JSuEukfk29wcWh6xc=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgphAWFBQbyQxHwqbCvwEwIl9NQxnNa
 Ewt+3w/AUXP10QAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QMbVA4PlLmx7PIWXbMAdgOKviQ6LMMpAae7/RAIZBDLUPPDtkMhSOSE1mADpT4y48lqKxZk8z3+
 EYaYDEuG0bAc=
X-Developer-Key: i=jstephan@baylibre.com; a=openssh;
 fpr=SHA256:PPc8djUi3lnQXuiRHH4CZ/icbEYOsksrEsOV7pDEmZg
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

On Mon, 12 Oct 2026 16:32:28 -0500, David Lechner <dlechner@baylibre.com> wrote:
> Remove .fdivs_offs from the fixed PLL clock trees for MT7981, MT7986,
> MT7987 and MT7988. These trees have no .fdivs table, and
> mtk_clk_id_is_fdiv() checks tree->fdivs before looking at the offset, so
> the value is never used.
> 
> The offset used to mark where the fixed clocks ended, so it was needed
> for these trees until commit d09876c4f6ac ("clk: mediatek: add
> mtk_clk_id_is_* helper functions") replaced the ID range checks.
> 
> [...]

Reviewed-by: Julien Stephan <jstephan@baylibre.com>

-- 
Julien Stephan <jstephan@baylibre.com>
