Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F527606A326
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 03:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HJrPtkS5;
	dkim=pass (2048-bit key, unprotected) header.d=octane.security header.i=@octane.security header.a=rsa-sha256 header.s=google header.b=lAGViJXd
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0999A80D30;
	Wed,  4 Nov 2026 03:36:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ibopCeQsAJoe; Wed,  4 Nov 2026 03:36:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4882680D34
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793763386;
	b=Fu8k3In6QIar6rs4eCldX+WbS64uWarUVEOBlRKfdd13uXxYCKjpd9hSrCCfBsjUrLSu
	 LRPh9XiUMyUbnnJHDxqwZ1obiQrAmz+iWd7PlzWyZ+akzB1oBn3tt7bP4tbh96ivWzdw4
	 9yeVOS4yuAfk4r1woJysrcab6RXM0e3EFhLCiEo0RuIvlO+R+Nykt1ogUI4vbWU3+pXzs
	 6pnRzBlBLi7ra1VnavAmPXkEblZHh78c/BPW74uYB03eOnvbbLdI499xaQI7gy7JK5ntH
	 7Ja2E6CP3BnLrm2KZvT4sdla3l8gR7dsxGappGuOZjxHWBmnw8eAYOtv/CX7+cw97lg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793763386;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=HGU8Jpod1/Hc62+pYJnvRTnrjJiqAe+bWUl8fxe3dl0=;
	b=sVa4CeeKlko2xAMj1v4ZyiCyX8TWK7uEIsA2ZFocCkYwvnNk9aj9ivFGslrEtirlK5LA
	 +KV1QAhBz8NIHZMcmAYq8xldC1o1sU4tUz5lZ487GuDDUmcohfEU0Cf+IUvWvF155wTzl
	 778sOmEPFVNLLDb/zCJNmvsCKbkDz+dcdHTsmfglWVLj0YcKqJTi1e2Hgr1N+5wwBqElI
	 v4wK9KhK140o/S0GmQbD9ks1VoIDtJb90P8lhR2CuahzygM6TFw5HHkkjDpHlOPJ/Gq4E
	 mKSxvahVwnlBDD5/KyEHcdUu28Is5sP5GnfVjH5GVWL0prSefdGIO/vZ0CQ3xN+ftww==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793763386;
	bh=HGU8Jpod1/Hc62+pYJnvRTnrjJiqAe+bWUl8fxe3dl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HJrPtkS5iA7XeGWTTyqb1g0arlHxfE+4G4TRVAutpEeF/+lZ3dSWFZrHcljCafCGB
	 G4qmG8SgdjDtSLGBenvv3CwYB3zaTCUVquE8760y4uNUagGtT4nh/5kLtsWHlCoOsj
	 PMJ6BIqWtUhJjp0RfoiLUzcB6K959ynJzbiOabfaeWNJfMS9FwpE+6yXxDPt99eTyU
	 2OLzrtGUe6CfBJmC3yCicYlUcNin1QxeRrgTlS2youUOlnMwoJuD/BYsOxpvJ5mMbe
	 pi7i8xHY8KQrSepO8ZoLzKfZh5fQHnVkB66cyYtWPvclQ4pvwdBkXJSap4DXIZ7UQ9
	 53GfqWbBneRjw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4882680D34;
	Wed,  4 Nov 2026 03:36:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 14B21784
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 03:36:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0647860686
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 03:36:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pIj3eb9gHdtu for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 03:36:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1076F6067A
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::122d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793763384;
 b=l89RjCy/VWlOvJICvebVVICIG8fY0iOxtps23nsyjZDWih46zU4RE3RHxoaC8N9stY2R
 r1fwPbzw9vbs3DnwxSG5sw7fND8kM5sO5BkDdOePj9Q9S8ccfq5zU4jqgfNA2OKMVZW7D
 PwRQLu8JMUA6EeyyLN5PEuIjMQ98x9JJCfAOGzYLbUZwhnLQEDjhpQsWg8v58PeIcGcsX
 xo8LAScXA//fb0FgRkWAPXPAGi4UGvbBAGw5CF4/ESC7z/Si8C8Kan5aFoH+Kw0bsUrQ/
 YWovDB7hmeCs66ohCQjcxA43T7qZL+orUvFWTe3vcO7/10tLolmJPgLqutAYjA5gzjQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793763384;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=HGU8Jpod1/Hc62+pYJnvRTnrjJiqAe+bWUl8fxe3dl0=;
 b=VOFhnt7E36AIe2ONNV1kDxJ2dhJiKq3wS5yGP0ehsw8b5d82Ge3g3BP+Wb8sYpe6rFZe
 FpjGEaHJ73LR+yK6a3iJPwt9TjCkPNZRCxOss1CUYi8XqdKouZIolKD7Z4YzmN+qcUJ9j
 ODE7EcWZo1fIE3qAUO477xjYY0xhDLwkC++IbRFtsHxQwxjRXd+vx+Oz4ddhg6O2MEdUC
 CsYiw1o0V4NfN7PETUQ/T92xXnK/mEEGu8thKxzRZOxGTpL3yYtduLSZC1tMmty96xJHj
 jOm7gUyN8q+iilChI4rgSXnJfuFPTSz33pYdlT0jBLRoOJ9lwtp56+Hv7aMpEWEwEAw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=octane.security;
 dkim=pass header.d=octane.security header.i=@octane.security
 header.a=rsa-sha256 header.s=google header.b=lAGViJXd; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::122d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::122d; helo=mail-dl1-x122d.google.com;
 envelope-from=shubham@octane.security; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=octane.security
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=octane.security header.i=@octane.security
 header.a=rsa-sha256 header.s=google header.b=lAGViJXd
Received: from mail-dl1-x122d.google.com (mail-dl1-x122d.google.com
 [IPv6:2607:f8b0:4864:20::122d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1076F6067A
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 03:36:22 +0000 (UTC)
Received: by mail-dl1-x122d.google.com with SMTP id
 a92af1059eb24-14fc585291cso281494c88.1
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 19:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=octane.security; s=google; t=1793763381; x=1794368181;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HGU8Jpod1/Hc62+pYJnvRTnrjJiqAe+bWUl8fxe3dl0=;
 b=lAGViJXdO3YziQYIj/4LBUrgPhnG/pqgavorAwu7JgjMl7LYzFkein2XgTYP3o44u+
 c7gYE7xCb+6ZGk9N5+kM5psG8Gsk1d080wOa0hronlduajDgKF2zCccXvaiGlvTvHknt
 C6bxveew7e/9T6Yh4C+HOzVGWQzg1QYLckTrJLHEyr5vyC31jaMnYO2kywW24i6d2Nqh
 MLhrjaGc1JGzRIbBVZoVoZ1zjf7ucZU/QsyUFcNkeG0EsEN77gPvbD7y3Syb0UPIB9Kp
 7WUYBVGaqgYhuBFJ43JKFRiM2Z5HTff3Y50Czmpp+/9WBxe8uGzpfNvR4aJpEPfB6Pyk
 uq0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793763381; x=1794368181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HGU8Jpod1/Hc62+pYJnvRTnrjJiqAe+bWUl8fxe3dl0=;
 b=BeFzvJO1Ke7FKrdJ6AgtIcTpKFloDGA+b3LDQb0aCa2WwmLUcWgs3faEbuHiZEHgQs
 NYh/RCt/r3PKZH/LtkG8MTH2TExgvP1946M6S7RkkjzPyDf1x7JurVHkoSf+FcRoBSaB
 w25lXYCeyndvZgIA5FMNMgsGklmfVWKvArnRjDG+RAPBoGdLSbeeohgqSf89qguCNONy
 PJgKXNRus+uNfQDwVrEByWr3wj+Q0Mn/xuuiY7GqCC/ZCPq8pmMnMhMem1zVot6Ncyot
 B6H5Vg0+mVF8gQ7Lnuizo6BTkyQaG9Ly08xmxONA0W8v87N6N5NxOFN+QVPjdCwsxp30
 eUAA==
X-Gm-Message-State: APuU4Z9nGbuXDPvPzcOzs+BOEjYX/M+w0ADfjlxY9zzmpQBuZAcJIugS
 pIhwjDM7mAZ2jJ4lstpS4ypKOzgh320vlm2/XQl1XgXXNJ8gDkwz18UfKmIQM7GijFxRWUgHbU6
 Qum4z
X-Gm-Gg: AYBFou1ip5AaARoAAgpGx5rYLRpL78r1RkN3t2PqtuspGfgGULxLuG9UcZiPoXTOYwv
 NQR5JjW5OUiNLgabeosXydioVX92igmbrOhOlEbetqT3rKxokEZg54nNNqgshpA+OrbV8Op5sfK
 l4k4kSSzQ2AxByv3nqGF/tsAIlsLCvyhfV2PaVCSyzXA6zTv1uLRtCb18d0WXc897EnKzDqy+Ca
 AZ1IUSSSOmyiDdh/QXQtyMzhg/uzckR1dhqynSZRwdXLxc9uPsr/db6OVq6pVtJZoGs6PZS3SC0
 qdfYaPPyykNqyg8H7M0VyWOY2JKFX1ErRH0jo3tfeSqbzLGUk90NHft2jxzXC0bG856nokwgb+a
 CyuY0pn5rlGizNhBybJJ/17BSGrrnijaiOHQXzWO8Hnj7umZ373o2Ot7SEUnnC8ezuUd3WptcMy
 NkWGis/E+lKO476tAESZlvXhl65b2P56b1cYFtaDOEK26z3k6X+X9z29XxoIqbL/EpFXseUNm7J
 kPAD4OXCydvr7+j1w4KzmeRD8NDXzxbM99EJPrJSkeohekGsEIlBRxG2Zv8zs9nYTgsh1Qe5nZU
 LSJM1m1NDMGoM+bufpMzjpwY8s4iDZsL7Ll7DaeCUsFQ/46bn1YK9oTRwqXEY2OcKt6dVjpE9R9
 xpPJD2gebgM/eP8s5pYvoCry8GteXtiEqVqExNpNfHf8OBrYS
X-Received: by 2002:a05:7022:7f07:b0:1b2:373c:997 with SMTP id
 a92af1059eb24-1b2373c09a2mr10060586c88.25.1793763380630; 
 Tue, 03 Nov 2026 19:36:20 -0800 (PST)
Received: from localhost.localdomain ([103.196.55.178])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b245c4f83fsm5151159c88.17.2026.11.03.19.36.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Nov 2026 19:36:19 -0800 (PST)
From: Shubham Antil <shubham@octane.security>
To: u-boot@lists.u-boot-project.org
Cc: jerome.forissier@arm.com, trini@konsulko.com,
 mikhail.kshevetskiy@iopsys.eu, gio@octane.security
Subject: Re: [PATCH] net: tcp: account for SYN-ACK payload sequence numbers
Date: Wed,  4 Nov 2026 09:06:15 +0530
Message-ID: <20261104033615.56104-1-shubham@octane.security>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261102110508.76420-1-shubham@octane.security>
References: <20261102110508.76420-1-shubham@octane.security>
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
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello,

This is a short note on the security issue behind the patch we sent on
2 Nov 2026 (Message-ID:
<20261102110508.76420-1-shubham@octane.security>).

In TCP_SYN_SENT, a SYN-ACK with a payload is delivered to
tcp_rx_user_data() using the SYN sequence number after irs has already
been set from that same segment. buf_offs = seq - irs - 1 then
underflows to 0xffffffff, and wget store_block() writes the payload at
image_load_addr + 0xffffffff. The header is legal; payload_len is
positive.

That is a controlled out-of-bounds write. We score the proven impact as
CVSS 3.1 AV:N/AC:L/PR:N/UI:N/S:U/C:N/I:H/A:L = 8.2. We are not claiming
confidentiality impact or a shipping-product RCE; those would need a
consumed boot asset at the wrap address, which we have not shown on a
vendor image.

This is a missing sibling of CVE-2026-29008, not an incomplete fix of
it. 29008 is a negative payload_len from a bogus data-offset. This
path uses a valid header and a sequence-accounting error. A fix that
only rejects payload_len < 0 would not close it. We have not found a
merged 29008 patch in mainline.

Affected: CONFIG_PROT_TCP / CONFIG_WGET, introduced in
bf962de97c37 ("net/tcp: improve tcp framework, use better state
machine"). The posted patch accounts SYN-ACK data at seq+1, drops
pre-IRS data, bounds the TCP header length (which also stops the
29008-style negative length), and makes the wget buffer_size check
wrap-safe when buffer_size is set.

We are not attaching a PoC. Happy to answer review comments on the
patch. If a CVE is wanted, U-Boot does not assign them; we can
request one separately and add the id to the commit if you prefer.

Thanks,
Shubham Antil
Octane Security
