Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B33B606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 16:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PuwnMvcm;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=uRk9BVPo
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 654118116C;
	Wed, 28 Oct 2026 16:02:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L-sXqjmjpl0H; Wed, 28 Oct 2026 16:02:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 41CA081115
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793203320;
	b=QpCKYkQ5AHWdyBCdcORwaoXiSBVQVeoLzY6kWjzGtW3WiaUTsca/mDjt/rcloVpFew4R
	 5tanY3mSNIF2oJNjvoZI/8qCUjfbyfq8dpTzuXf4qXiwGmrHrAoDqNM/pT7DipyK50b+B
	 wO9VxU35hcWJ8w3uWW2BH4YgKK4JynpFI1zY9qkf3MizXmxNjT7GR3FekF4ooicTtOG4I
	 dkfhMgqF2p7MK3LD67U7/GdL3UBmMkSC+gaRzinaQFGqKsQhcSais1S3I00r5fx41NQQF
	 D3lmXPXhnez8cRvB7m9MuEX66zurVG2LaSlVRRqFeiTDok+IR8bAVRf3CofFl4Iyovg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793203320;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Y9j+sfcyJlHzWCWIOd7Jp6SUCd7X8y3215Fj0AMTPmw=;
	b=m3glAj8/3N3DI+X0t6mn+rU0peaH3KFgnsrL8qwAaC2heG5TAfvFwKzlmx9PP7bQN+y/
	 Rbza7GV2GT1Vxxz1s4KxnP0a1ud0pKR2u2gFlP/ZKKBKRniaCHXrg3FhKnM/nnohUU3TT
	 SZZEln3UKYSBEqdyQ2F3A0IGvBy03B3/8d6b4TFZM2LsAC/lNnBjDC/MvEhD1RjlUf3nR
	 4huRhCxs1y2NuHXWVCaNbmoL/9OGikSIdBfcdG/TXTl7/8ExoIVJj2OGbN+LSjbOHa39b
	 vSGNxxHFLtg23Pc03/PtXBNDRfFioruRQua3D00MB33Gb7gvOxNGns/KQaXD8XuCSJQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793203320;
	bh=Y9j+sfcyJlHzWCWIOd7Jp6SUCd7X8y3215Fj0AMTPmw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PuwnMvcmbMfqUw7hnfe46NMHgxov65+KVH+4sFs9vrp+thbWOvIY7Oq4FvZrC762Y
	 5UO+GVTsoOs/osPAE/aWMi7CJqQNlyunwTietSs+gwHFpHphI4nv3H8TK4LSNB2dkh
	 dIJ4NZ51fYobfwEjKoXHcXzXhrb16CnLVqnuoeG8rkPU8xVHm/iqqOBO39HitOAo3Y
	 ZRZC9dyvzRmxdXT5hIhCc3tKCMbM7EPP6zJJI3SGAxXEUG5ukT0PVR+V94944E6rku
	 48yvOxCclvT7IuFoOQG7yHL3DMjGkSf7hFYBVZATjxpCaDi57T4gdzzPL9Nn4xCzDX
	 MvFGrCjgaH6IA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 41CA081115;
	Wed, 28 Oct 2026 16:02:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id F3A95235
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 16:01:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E556840536
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 16:01:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ej7tB-8bbroK for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 16:01:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CE1DF40533
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::131"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793203311;
 b=OA8k+XQd8JsIexNEqJIPai6lsBXpqiWyxLJLRZU2Uox2+SSVAZTuyllE4mdj+K/vYp6w
 YL+RGffwIf2XM0kHWDMZ4Noa0Vqe70vAORVyUY4wVf57OCutjpW+DYbGalURR+AKDWfqK
 DQnub+9+W0boItVLkU/vCxDJ8fE4imVllCAELozUasJYlbeLo26gep7jYD9hr7P2vqK+L
 vvKFWsaIoVZAx8UgIX5Z1xYGxREDjv6NJ1CzoYAXWctiwRkq3MDjH1e3qWoYjnpIWHWvT
 U53noCPHNpwqNsLCFcPvdMqX8lt5Ye0obYZSTDRqmoCwSDV85blG6k9kJh1Nev4o7Ow==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793203311;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
 bh=Y9j+sfcyJlHzWCWIOd7Jp6SUCd7X8y3215Fj0AMTPmw=;
 b=HUKxMNsFhz1ARedNLAgJZ7WAVmbMyK9zSe9DEyTgKGzr4qz0jZ7z/91tn9oj3N6Mdwr9
 zyID/CTM7GXldcpjZZQaWYcyw+m6Gb8vMzVZCdtJ+3mz1tClkjdyP2dy6UX9hsp9uyauA
 XP8RAnnUQisJ3gZwboaF/Ao4pWL9h6dzLYHjM6fKeZXqB0rjD9MUr2IVuVJHlwdwn/WX1
 NWWLq9xnIdcq+9TUO8xL8m4nrbkjU7dKFim7nqxL2dggOrcMmAkXju7/hIf2IaoOwaeUP
 3mqgwhHEzteSL0JBvQBKRu4bT5gs/U5XgjcayEu5GCvTM4gYrEMetF95fOOyqsSx3tg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=uRk9BVPo; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::131"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::131; helo=mail-lf1-x131.google.com;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=uRk9BVPo
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CE1DF40533
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 16:01:50 +0000 (UTC)
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5ba3ac592faso1391785e87.0
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 09:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793203308; x=1793808108;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y9j+sfcyJlHzWCWIOd7Jp6SUCd7X8y3215Fj0AMTPmw=;
 b=uRk9BVPojMY/f0Vk/hhW/0PrPOH3w6IBc02fzbX6+IEJ0MMPUiPgmeTRx7/ynFJupo
 jMXa/TWt0kUQ8fASh3YZ5K3X8YRjrBjIJJvZ0B74usad5K07sGwq3Y1tXa3t9s8K/ml8
 /Gk+mAD1cfhKBR3J8KijihW0XxLAY7SGTjClB/hvqW6kmR2170DRtKIOOzBoXV2b1dev
 HvgwNKk+MVIyRt+dDzHeIdEGkPl2HbGQ8s0uxe6l27XE/ILOiLW9GS9IR1Dvj6YpabNy
 uTQXH++Aqp07Vlj0OIQ0h16kmjQt3+NdRUH4PFzA+NjIOMPMhSsWsW6s9bT8ro3JpZaq
 GXKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793203308; x=1793808108;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Y9j+sfcyJlHzWCWIOd7Jp6SUCd7X8y3215Fj0AMTPmw=;
 b=U9X7d0Ez6g5Kk6mlRa2jYOYtvyKrAcXJGdEo4PWNzYDoV02Jb7x+bMTK3VrMxNoOey
 OX3uFRx5KP/1u4nbH15f6RHfKAa1VmJ4eANfL94w61c2whgODSdpt5cKg06juxy7HWKP
 oMMW8Kye4MqA/K4gFwi2wRG97R7qZ88YxqvKO00rzon//lWqVM7FzpMYcm1ADZ7lLxwi
 Vb734Jou36rR3japoAYkfTQD9FH2zVXfi1xNwvD8x8PBrgU+Ry5dWTupdBV4dkaYhgbC
 M6CXNPv6opAKfqO2ysnyu99t6g9HmJFzpryeS5TYj4pSpnmcgzJn3LuRlzSJw3K2hO2o
 V5CA==
X-Forwarded-Encrypted: i=1;
 AKwUvByQcdryeEEPsl/kpIRvWOrpxeAd5I1bbmw+T70BwKbACyMCvdBywVcvrrWxVJAyoBn/YJKKuqc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLcrkInpAttGJ4QyT40RfvaWFI4S6WqfHfNUX5lozZteTGt7rlb
 hnR7Q7VZk4I4AqxIWj3mbLtBp7RQ5/U7Ys17rVHyHWPTJB8TprSi+u+D53PyYNUSIcfafXr1kvP
 V5nIIsbg=
X-Gm-Gg: AYBFou1tKtomkluR9HMqUkP0K5fYSiaKAqKGCrVKUhYv9HrwPWT2chEYlJ/ie+YQu8L
 ee7Q6IRodMhhDkxZF09InQDVIZjGat9V7MHC6sybqr6PStig7NixvOd2lTc/1YKJzC3ksAuhdv6
 pyQ3myhCKQV2ZIhZf7IRiEkfRuhOWHQhRcHsyARJ5OpkRf8J1slM4RJ5EzcAT60t2wWpZYIsdpJ
 sa+tqcNYSlWJCckqQX7uW0gqN27ljO7/qKbyF3Tjtb3EHg4kbEeep7CF/BI2bC7jMpSawb8gbon
 t3ZtQQLn8cdwGqzEWCMbbX+biSyeWoTCehvttT8cyr1WKGLiz7ZL4rwpcPHtGF2funiKXYY+0oh
 fjyQy+afy3htVV3YMwYmIbBUbAU7g7GxVwLnFcb2hxyKnKcC/4cUYtY256GgSnaW1IcQIXT9ftx
 O6gzGO5aQhpZIGNP77K+td90ekyas+9Z2Rc/bC6FqdKVqBL/SJaZkOm/Ij0l6iKZvNvW8p7MCgt
 KIrgP9eowbKpRBpkXsFtZtWFM0cKqf5xA02wKErCt8lgwDZkpTZOnPsUoQaexWTehZPqfjuHJCn
 fmhkuSZ64mg9qCbBP6CgTsuAZQWwAjHHEBuC3Q1S1RWJv9h68rABaMug5hw0halT5wsvlg4=
X-Received: by 2002:a05:600c:609a:b0:4a2:9cda:57cb with SMTP id
 5b1f17b1804b1-4a963ffb29amr58143835e9.1.1793203297305; 
 Wed, 28 Oct 2026 09:01:37 -0700 (PDT)
Received: from lion.localdomain (p5b29ef1e.dip0.t-ipconnect.de. [91.41.239.30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa80286fc6sm1686155e9.15.2026.10.28.09.01.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 09:01:36 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.u-boot-project.org, David Heidelberg <david@ixit.cz>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Petr Hodina <petr.hodina@protonmail.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Federico Amedeo Izzo <federico@izzo.pro>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, phone-devel@vger.kernel.org
In-Reply-To: <20260904-b4-sdm845-usb-gadget-v2-0-cf1baa65a6d4@ixit.cz>
References: <20260904-b4-sdm845-usb-gadget-v2-0-cf1baa65a6d4@ixit.cz>
Subject: Re: [PATCH v2 0/4] sdm845: Configure USB3/DP combo properly
Message-Id: <179320329583.1454330.7412906293709750636.b4-ty@b4>
Date: Wed, 28 Oct 2026 17:01:35 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
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


On Fri, 04 Sep 2026 19:53:43 +0200, David Heidelberg wrote:
> USB gadget mode nor serial console does not work on some sdm845 boards:
> 
>   dwc3-generic-peripheral usb@a600000: failed to enable ep0out
> 
> with exception of the first boot.
> 
> This series implements "qcom,sdm845-qmp-usb3-dp-phy", so the USB3/DP combo
> PHY is never bound, GCC_USB3_PRIM_PHY_PIPE_CLK has no source and stays off,
> and the DWC3 endpoint command times out. It can be masked by an earlier
> boot stage having left the PHY initialised, which is why this only shows
> up on some boots.
> 
> [...]

Applied, thanks!

[1/4] phy: qcom: qmp-combo: select PCS register offsets per version
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/0cd30ae2bea5
[2/4] phy: qcom: qmp-combo: add SDM845 support
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/2c7958df4dcf
[3/4] power: regulator: qcom-rpmh: add PM8998 support
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/60111319e459
[4/4] configs: qcom: enable QMP USB3-DP combo PHY
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/8c2aa7fabe5f

Best regards,
-- 
// Casey (she/they)


