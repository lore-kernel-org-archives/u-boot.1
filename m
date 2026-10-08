Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B76CA600B
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 12:46:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4DDBC81222;
	Thu,  8 Oct 2026 12:46:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bp1xt7dgOvqO; Thu,  8 Oct 2026 12:46:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 738BD811FD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791463574;
	b=IwxkucKH6pkRI0PigoSwlMDOWPuKnY2ELxuTrskkC/DwNqSIHnewFZbC0C8Zhary4ut5
	 2ItbQlxy4ftRaS/Wg6Cd6MlrG1qLY2ikeCz0UW0xUHvSJ+JNjvDPJegI5KPnH2fObjaJG
	 GHaBWQzZAEKA9nhIGIfXNfxAzNVD5ne9KHWMKmEqbtKGtF6G9XiTrW78XTqcgWNg4NHhk
	 Kj0P4Z8KGNITXdKL3v4l19hWbSdtXCsIfuGcw72J2F+UshCkZcRccv0P6ZqPW8HXtLSOz
	 5Ru7NT9nVmfNJjFmj0W2b+fVuSfRpSC6RPVIc1p9NUh7e8yQPMFyknwAp36gc6sU5Sw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791463574;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=/4sLId22U1O5OuiQ/PwuY3GwdDe7haOu5JLONqeMvhE=;
	b=USW+SdE3kut77vX+yK83sytZXZ6B9C0Wr6Sa7ezZA6BTiEZmhLbryslmwQqPU+Vef9jt
	 EAyRMVv/NdOcv5Z2i3IQSCmZA92Y3ocYmXRxGp6ro8IofRPMyqR2xjKgGHbTMAfrlGBlV
	 dkOH++KqDLxtf/Eik+CuEAb72s3XweR6GwUeeBSJ/A0CosaikNVlolxO6GF6ZxraS+b04
	 DsSiPPE/ClaIyjOrtDOjRJ0+JMEwaBwu3P74v1c7IROaa4Sdr/lStCAQGcO5wCkbe+6p0
	 k4UFedwaVp6r0nFNE9+WGdh1GvpX493Rp8haZKNuSK3lIbbs+Vo1jmrjquPMYyJHIEA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791463574;
	bh=/4sLId22U1O5OuiQ/PwuY3GwdDe7haOu5JLONqeMvhE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VGdryjl9AREtf1TJCJWdeMmodQqvEQCxGlglGFvcKBFKI+tRPfmTn+J/hngdHHcTF
	 c9q7MOK0nsETeQ20OkBAKmv7dS7v1VkkNPLSJJXgg+NF1D3FNUTFoeFmNJqU999pYy
	 cocW77yjyR5w5eD/2Dyh+1CNpz4URjrtThVMRVhhAolttepaCLd7CRnrA2MMp7D5cW
	 ro5Hy299KE/+BKKUAug/Hwec66S+JuCpR6VoBRkWeg1JasOBHFDnkGnMPqsOJArvSa
	 v6hATV8HHmmH6zN1lJxusyLwbcgHNu3Eg3127ha4iLkPw4iDJu9h+9WTwQk206K7rU
	 r3ZhD2ujU1tiw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 738BD811FD;
	Thu,  8 Oct 2026 12:46:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id DCE522E0
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 12:46:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C2FEF40456
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 12:46:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U9CNN4157v3r for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 12:46:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org A0AFC4043C
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791463573;
 b=e2O6C4RuuztGLBxPq0e7nihrL70gQ9c0amZ/mdivsjhzvq1G6pJXcXB9HJix96/4NP+C
 hAJUGN0ambb1AkIFL4Y6SOjWJQhnAcBTHaz7ahpVQlpA57MQH5EJpm2ONQptqv/ygA62+
 kipGo5llnvjDxG6nSxIzhfsTuJmdqVap/lm29Z0aeK1q9VXwrV4OoCM4laKgqTuSBQ5+H
 3QCSlHrCdg/wYAHhP2ydyXzp4HaWzkI2ikMFQ1w2gZkpE0ix7opa6rjdCQLNxA3DrJXiA
 qzCYev8OR0qQSSxvZLkddK5P9yTyt7IcEQIvgF3R+ZSlCGaNll414QUr2zAfUFjLdzA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791463573;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=/4sLId22U1O5OuiQ/PwuY3GwdDe7haOu5JLONqeMvhE=;
 b=l1o0sRaejZHCQ/e2NTAamcjV9aKeFp7ZtDi/eEIu5O42Liq8aUNFm7b/H2jlHZ9r96jM
 JGfIAqXw8qBb0DAu80xGodbetqNfoUXMHR5AQOfjRw25CqBhrVlvuJynOMuHFMEmNWxS2
 ipcGG2MT3PQulPuvpkqCbRhp9om0IGvguMipjLP3zkD5bVE+HCUX3krK6ssy9HD/puHmM
 V+R29UOuPRMtjNdAErvr0tm+bNedERoVaA+n/e7uvHFyXVi/UCL1ZDOYGzxWDph/R0gkb
 QY/u1bOtSBJ9TdAYlnbWZlCS7wsz6HOxZzMwbejlFtOOwSwuUmGm8P6m5u1Ky2fdSwg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=MQDSyRRj; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=MQDSyRRj
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A0AFC4043C
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 12:46:11 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-48441a2ba1bso3076872f8f.1
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 05:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791463569; x=1792068369;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/4sLId22U1O5OuiQ/PwuY3GwdDe7haOu5JLONqeMvhE=;
 b=MQDSyRRjTDlk1oDkQo5yIc5+Gh51pyPx48xQLKxGIpblVwlQxvEJce7CVtmiILjRZ9
 +VBG9ryVBeLhd0ryukrWvOWYmSDxxxZS/z3pWopNReLM1mX19NexwyO1a8fHqH8uBdjQ
 DVPCZgRHnf4Xnx10JsplyEw8nMP0S5Z9ccPf2HUjYXM5bPFvfyxPP2Zu1syQQvcqDMJ2
 dhnQmWQ5wibAfxmlTeqBr2YAu3yl3RZFzEosYLpRrm6fQcjZUMHyj9woHa0mWnKJS00O
 oOBSQBBDkkkP0hA7FwotbKHA9jcoFO9STTiAKtitvUGuKqg/s//WRpgV2/gVERds418V
 ks+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791463569; x=1792068369;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/4sLId22U1O5OuiQ/PwuY3GwdDe7haOu5JLONqeMvhE=;
 b=GFksfXmii9plI2iwPILBK4D7PEOxKb5oX3pLw3CXFif9LCqgh7mv0EBGzWqTRayf2Z
 n9HUWaIbtYdmmYJ6U26PQMnjyDY55hnbV1U1aepwnTa/GLv7GWQxcu1M4+aWrwfRNMKC
 i6AJy6IRd5AZGpg8RO0DS/CjiIzVT4Ygoj6XOOMduSbxAQJWNdxdNlw8uzus6FgIQeyY
 i08lh/0jUrzGpDPtYkjeKO1CqVD7re1ypYBDCSmE9OZKKNizS9XiCQ/xZmnn8ErO6kfT
 ns8hX8kMB2OQdxDXAXwV3qWwAXXSEQnDkkDenNhCAl9VdyESOiuCSeCiZiEnC1vv+9dQ
 7ryQ==
X-Gm-Message-State: AFq9FYLhiDNxMZqMWpr/I+XFeF8K06T/kM9ERTNjDyvoRs+RZNOrheZR
 oxWm37mfbMaJiGd9r64/JDH3xUVyJtQH9ZeThvFaw7MiaK7WxQoZaun6ZYHXp6NdKONJaJVt8ik
 1B3t5nOEuSQ==
X-Gm-Gg: AYBFou0xNgmtaHb9EoIYz5Lq25woNoGJMvinwgr9pqidUbL9m0QnB08HN08hkNiWCw3
 0P/7CYSyrIp8wubfnmGji+JGQAfR8NkBjj0unhyPLXtrbFfrw+juH87g1OPNewEIZ8Ckxpoean+
 o47l388DtezuT7INccN0YZe13Udg1reOZRgfFCJgYqXcqu/qtKoEriv3lYPaTj9aj3BT9LvCNnd
 MjrV3zYKMst7uipkXZYlB3bx3TsbUfMVnZyFQRHEu4B2/DLZyYDd9ni+eSdpWLpgpXaRCh5+tLb
 5OZeLu/eYA2klLlZcvv91oYG0Q2kw6hKrHy+VX4C+x+cJ+t/qLhLWsdDObGdMIjvaXlDuY0wv1V
 MzfgS1AX4n3aJowSZLfhlSdxkdd+ynP97qyQAjEYtMKSKiOWSUZl7TEL3klqhLDVbN5YzYNJrQj
 9qAnnjNFph4DLgn6qqzA4FKWaewGSVx2ZR5KMC9jP1WP3NJCfKe4NH3P2yHWQhqyR+O4UR/fjK9
 4Zj0PPVWUX2el/ZmRURzFGBLqT1R2A=
X-Received: by 2002:adf:e186:0:b0:48c:6d9d:9f90 with SMTP id
 ffacd0b85a97d-48c7288acdbmr11069958f8f.26.1791463569031; 
 Thu, 08 Oct 2026 05:46:09 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c71d04c0fsm11015183f8f.10.2026.10.08.05.46.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 05:46:08 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: u-boot@lists.u-boot-project.org, Sean Anderson <sanderson@brivo.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot-amlogic@groups.io, 
 Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <20260817163048.1892107-1-sanderson@brivo.com>
References: <20260817163048.1892107-1-sanderson@brivo.com>
Subject: Re: [PATCH] watchdog: meson_gxbb: Add support for s4/t7 SoCs
Message-Id: <179146356780.183177.7943400413025163091.b4-ty@b4>
Date: Thu, 08 Oct 2026 14:46:07 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
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

Hi,

On Mon, 17 Aug 2026 12:30:46 -0400, Sean Anderson wrote:
> These SoCs have an almost identical watchdog to other meson SoCs, except
> the reset bit has moved. Add a new compatible and driver data.
> 
> This commit is based off of Linux commits 55908e388b5da ("watchdog: Add
> a new struct for Amlogic-GXBB driver") and 8c776a0401f1d ("watchdog: Add
> support for Amlogic-T7 SoCs")
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[1/1] watchdog: meson_gxbb: Add support for s4/t7 SoCs
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/4242282e4ec21438dad1a99b0555840b47f04d72

-- 
Neil

