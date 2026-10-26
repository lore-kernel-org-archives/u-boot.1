Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DEC606A320
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 00:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GBIK3xLB;
	dkim=pass (2048-bit key, unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=M7CzGPgn
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4427680CEE;
	Mon, 26 Oct 2026 00:54:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E0F3wqJtJMQz; Mon, 26 Oct 2026 00:54:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8D3CE80D35
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792976085;
	b=XPY+NHC91X7WQH3U1nM2hsZNoinwe30lZDBMLihz1hfdmnPLdDxbqee4ndJdsAHbUy4y
	 /G7nBRuyt2ZxJKp15j79GIs6zqaRXQDMIlpkLtPR7UM672BSqdLykiPNFyE1GkzUdlsgN
	 JBp3QpshYcaewUFIiaj1gbvPqQS6yr3mazijiBiUgqWVeCSQ12/n/FjWkBc9JL3pQZIuK
	 wvgdhmYxWb0vK6iK3SkQk4ET2DFfAGqql3dXcO03ZVnggnHWBBFwrWBGid80VUS/sVRgY
	 XLjMHc6bDrsf/UEcsB48anJrDKJbxaCiQssS2trFC6TibGSSsYsXFnPjJ0hlqE0WQ3A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792976085;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=3TmiZPf28GCdL4HdLlONaxruuTRsi68LRTczGHAHwtU=;
	b=jan+rbW+5F7XiZ83jmf7z0QLlZwid+T/f10TnnpiuR9U2lmUdDyTAM0kzfsdgrq4QO+1
	 +/KN6fKa/EGsd+9y4v0ziFIq/6YjjmdI22tslTS87ch4fhst1q0BimV4HycgvKAdbpr/6
	 nfQ/gcd2ThKrIRFmSyzdI+HoEVtaLcj/hqo+NDyIQRYffeBiQX/W8doN09sr0+oljcSnX
	 Qym111ctnQiv59T3HtcjXTTHtPgUbzawzxBbI5Wi4/4Jrgjn8EiPiJTYfs0h17PYOw3rR
	 9y0YQLMRUbGvrDfRaMJLbk2Fa2EJ34RXxDzXZqgagxS++m1OuxngUngtK2lrg1YrOWQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792976085;
	bh=3TmiZPf28GCdL4HdLlONaxruuTRsi68LRTczGHAHwtU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GBIK3xLB4XJjIbuZHJvbtL4WyNaVZRIBbWF9R/x1LYP+NgYUOEtNEfT2SBZnu4k/g
	 QHBmDdblZ+xEsVTj8PMG/bUaBmcc411/IgvpA4JZ6qhUNfmM/9Tabh6OONrmedbFsv
	 cqta4mlaKKdng1IqgrQxDWGBmcVtt64ZvQTSRlZpI2ZonU5bjwjcG9TBCDI/xcxzNn
	 /dy9q/D8ErwFKvT0XMgyLs+gE+IjdMn3VbKJmxVEHvjkPPDfnzrHo7SXeIHP5UMQvC
	 +DwAjM8j8qnvSxHxtyTVwpJhZiXJ5fvxPYWO8bFHJPN+UKDWnoLpQ4T66Z9F339WTn
	 cGcAJHDYz+O7A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8D3CE80D35;
	Mon, 26 Oct 2026 00:54:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B39A6334
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 00:54:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 87CAF6060E
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 00:54:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZL3AX9jSZsuW for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 00:54:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E788A60600
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1031"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792976083;
 b=OlaS/FXrhk5ho5lAurrbwUw8hS2vNSr4mkqx57oPWj60jRHcDo0Bor8/4Szog4+TizWo
 mUvEWb3hC8It20DQ5/weVR/TKbwVr+mQGj6nT2hTLgKUdVz/CNXdxEiMxzXl9cDj5m0u6
 7+SCKT1rGtI96t2eQoZ2Ak2LAUW+JoEoNNTbCl+XQhGvAmA41deHIX1OqLE4dqS7+ub8y
 65M7NCpjcNkgioYHGblW1Y+Eh2IXcQP9fKvgrLGAlVRBlisrZDN5usPgOphd2jjiTd14v
 oCBrMC1yRxi4yFrsERfSHoDGvV2XqyCGnflAjV8yvrxBs4fJEtZ8Xo6YToB2rWJSqHg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792976083;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=3TmiZPf28GCdL4HdLlONaxruuTRsi68LRTczGHAHwtU=;
 b=kK6KuVpskcM21O764EUpXMUqHZ8oTZWOPlyrHuSWGa3UFdESeierHdUdhRJfLl+Ae5pX
 c1RTrRp6pPcAPxUS3BQql4lxT+4Yo0BWo4Lh4zTOOSbo7I2t0MQB5J7Ecj59sYU2otKuA
 xQVhYGVQpysgfQ/AYPAwia+70JosQBcrHZlwVGspp0uYzHBilPnT3ETkVD6UXCSoImCqA
 BknCIMk669vakqknaCFXuj+JQBsTwRYCf49IvnVlScnWn25POb01p4hylBdZ8UvG4xES9
 ambLmJhxK2Zy5FFFyuTARrpRDMtIPBTlC6mR1KnWGTapKPqrVdDrhyj4//KxBJpY3Cw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=sifive.com;
 dkim=pass header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256
 header.s=google header.b=M7CzGPgn; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1031"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com;
 envelope-from=leo.liang@sifive.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com
 header.a=rsa-sha256 header.s=google header.b=M7CzGPgn
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E788A60600
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 00:54:41 +0000 (UTC)
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-3ab2cb8d577so1738605a91.1
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 17:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1792976081; x=1793580881;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3TmiZPf28GCdL4HdLlONaxruuTRsi68LRTczGHAHwtU=;
 b=M7CzGPgnEuQd7ezym4QI+gJIQ7uYWMqco55O2Sducd+t8ms8BNcu0zkMNO6U8rBRx8
 8J9HfdKdV/YgU2liBXd4Exn4MYi43OYFaIZ+2e+HJ+YEXWZrpWJ0rEGfpPkOOVJh99EU
 wJ+6GQGh/R6hGRW+IqIMQQcP8SXTffk2s7UjYwvL/w53UASeLi/xi3PFjAA+Bpfp8QhU
 qdmSV7Ep2lCjDPTRFtkNIqBkuXNeOq/W8nom16C9rJK6R34Q3A8GJNbuTunfLKtNvCsa
 PSPPjcqariD4eVYZOsmwLOji8XTSEaXI7kybFiS4wYUFZ0xGhvWOnMvxZFXypgwNol7O
 x9rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792976081; x=1793580881;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3TmiZPf28GCdL4HdLlONaxruuTRsi68LRTczGHAHwtU=;
 b=cYQpcwAQc0P+3a/Yn1gGvtQ8hf0fA1/i1r2iM+vpdWJFx8jtMMV+E7+S7eBPJINEH8
 mULggIFxtkh4btQCLSTl8LlsvXgCNMY8cwcSyvTlka9E7xHSgcrYwfm0E/gwH82AC9ZK
 JqtqQVKqt/K1i07L4I+EzPY95+OCBLmRCyw9GMjTGsXUWr5DB0UL1xDk/r9mZQl1KzU7
 U3YP6Jh+ACdfnq2I+QI+Dn42z9gedoeTImJVcsiIQaIE6esFZ4iLIHWAxED/ffMmi+DH
 bt78e9Cx5VjVJFqxO0aqXepkCUkBgWo9WN085d9vDnYokZdk+x1VdD/+ig1cssBEpKTI
 PAXw==
X-Gm-Message-State: AFq9FYKgGb7fpZUbtYXtbvZ2g1rRSyfW7VU/f//jlGLPqzBs9SN3h8Tx
 rTtBiq9Nu78xRxm1BEOm19oua3s5u9jqpD3ayyljTEBbU8f+QxfIBpSeZiL06n2/nQo=
X-Gm-Gg: AYBFou1ygXeFhSKGUf/acPxIWw1B3tjsIRkTPe9kAZD3ShODVbwg5pL304jZNvl8pV3
 Wuc7IV+cBabjYet7/pb6nEExiFzSYXrSQ8KpKwRh8fc0Ci/hSiGna6FzTcVRD0oxyPRoFRd5jK1
 2rsM0Qv1v+cFWbRXUpsAxsKLBr4NXRwacfO7BoI+dlvxI8qD2KKZHcDhjc6OHyPng3XPPcvTMs+
 A8groX1gfHZKpBndAJpUnY30pYll4hNsQkjvb2o17cXxdhUTP5y7ScUfXZQKnkjCEZETasUVERr
 su+d8/Ydun+HJJDK44iZGCI1aPDLmtocrHHwGOx65/rVtpvvjWOQ8kr1dgK1rodKp7N4oX9Vaqa
 AhmmopOfcShYY/pXDtn0iW3OLLvgeZ0lSuTk/xokz+IpsIOtliNtGqERcZrf5BmFcfXOW6ydLaR
 3OvS0D7rzUom6XeQ8guCh2FmCzvw/bsXrPey50Fiy7LismKk5XSKaD5azBeD91fbAnTIpqblux5
 0iR8Db/D7NshF7DQbCUDX7MnV5wyWqmssRWEWowIjMIUbz6lHkDnBV4lWjL5mcslSi4eAxq
X-Received: by 2002:a17:90b:56ce:b0:3a8:9d0d:ca50 with SMTP id
 98e67ed59e1d1-3adeaae618emr4552032a91.10.1792976081233; 
 Sun, 25 Oct 2026 17:54:41 -0700 (PDT)
Received: from lliang-1876.localdomain ([136.226.240.181])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebae7f3csm5004225a91.3.2026.10.25.17.54.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 17:54:40 -0700 (PDT)
Date: Mon, 26 Oct 2026 08:54:34 +0800
From: Leo Liang <leo.liang@sifive.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: u-boot@lists.u-boot-project.org, Tim Ouyang <tim609@andestech.com>,
 Yao Zi <me@ziyao.cc>, Conor Dooley <conor.dooley@microchip.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] riscv: mpfs: imply the CoreQSPI driver
Message-ID: <at6kyu7FE9beGpl2@lliang-1876.localdomain>
References: <20260904131738.43312-1-pengpeng@iscas.ac.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904131738.43312-1-pengpeng@iscas.ac.cn>
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
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Sep 04, 2026 at 09:17:06PM +0800, Pengpeng Hou wrote:
> When the MPFS SoC-level options were moved to the CPU Kconfig, the QSPI
> implication was changed from MICROCHIP_COREQSPI to the undefined
> MICROCHIP_QSPI symbol.
> 
> Restore the existing driver symbol so MPFS configurations can inherit the
> same CoreQSPI capability that the board Kconfig previously implied.
> 
> The provider-less SIFIVE_CLINT options were removed separately in
> 12a9c83cba29. CoreQSPI instead has an in-tree driver and matching MPFS
> DT nodes.
> 
> Fixes: 2f7420ccaacb ("riscv: mpfs: move SoC level options to the CPU Kconfig")
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>  arch/riscv/cpu/mpfs/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Leo Yu-Chi Liang <leo.liang@sifive.com>
