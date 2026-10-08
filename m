Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B9ACA600B
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 12:44:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6CECE60B3F;
	Thu,  8 Oct 2026 12:44:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gRfCJolX53ep; Thu,  8 Oct 2026 12:44:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 886F660B14
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791463491;
	b=YKzj2IeRsNM8DXGtdl3+900CPjL3JZ4L2QApb3VvEDgLyESzGmldoqXMV5A1f/1aks3c
	 5P5fdsYfZdGgO6aHw6lBEBMrXBVd1wQ0EMGgPcXnze1KE6w9iNuh6OpZClqJKuFTITVon
	 yFhikA8/siu+Za/VzjuEl3a58JAhwSzQN3mRP+MPi0LG3M89bzbhPZelWaPBcZGUEZ74z
	 K4ZJ1pJzf5dTH/DxBhfO+yK6HR4BJ6RM+kpPYkR7JhPswgVdWYCUvkcefjM1nJ4D8PYVd
	 IZUe8ecJnK+3L0cXub1Tr5cxP4mk6dEw69tTLSTNkLO8Y/CMB+SxWGwl7UfueVWSQCw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791463491;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=qtj6r29uDOB1ISuFdxwEAe+i7VBUHss6K7rW1+T2I1I=;
	b=IvEWaHX32YK6q+o8HfjiKW4+dZdWwnc7qeKXQ19zTGAE0NlFAynw5B3dpxBFS3MZz+AL
	 BHPJeEBgo/BNPyB73smjQ8ITF2PVv56DP0g+rlLnzkdrTUDvC/K+dPWnKKBt11qPBG5J7
	 GsFGBIW+HQFingNMJBLTR5GY2pKDyDsGIu3JpWvUditUDLQ86fe6xIAjt2+iwecLVq6n5
	 yiWKzSTnviQL8MxwdU7bdGJZsok+pl3WuEEeauQNCSHhFeXLAVVVZeUNUI5k9nazlGi/z
	 H7/0uc9cDpCZ7oLYJ/udQdvjRyaMLIBnetewgXOiLecmbJAV9Id5T60HGU6ZzEH2EfQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=FKNDhB5J;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791463491;
	bh=qtj6r29uDOB1ISuFdxwEAe+i7VBUHss6K7rW1+T2I1I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rmH0Ux5qzZCbMPnGU3yOjhujNIgK53oS9ZCdr+xL58QghrrpT17Bcau2qCW+HjvDG
	 XnPxIfhfSPdXEYvLyWzI5n4MUrbSPUC7EC7/ng0jYRHky4OW+Gu6DR/2TY3sBSgJff
	 U3pThIBSw1cvJxU5N9eOijuIjZQtaG9prdZ/kiBhA/zh/cd7v3vRs3JuV78aBOmClt
	 RL5xTmGilogHqK9sVRTBclF6wq1LLnWr8JEFqXKlfa6qC6OvmDEFQ5nwX6jxrSvbP+
	 t0hDXJIf30BUQlK2m3nAnI3CL3etjyWahNoqzjoKkHS7QCqWSYj4RAUWvZhR3F/yEv
	 qz3fQ9TKXfyoQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 886F660B14;
	Thu,  8 Oct 2026 12:44:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D78191A6
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 12:44:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C8E03608CA
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 12:44:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LzI0GiiAi9bE for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 12:44:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 92BBC606FF
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791463489;
 b=ozxmyjEsQ1eIpISxS0MF/8iJQy6wZabgkey8ljBA56BhIUQ+xPQwx7EgsY+0vO+1/f+F
 RZSdfbh+GXBhwKLbYCm+Le4083yQ4Pp4sH92ZiT5jByh+IaZouro7pnlewo9uKxM/lAYu
 +KZYA8mDasB5kXNgtTYp/DnoRi67FuXQnqBhAxxp0kxGxOraOIbzLZ03HMIIOAegPWVXP
 dzPm5Ie71QBpsiRLhTLZA9cnBGJx7vlMMEwOPfCpr/wv9n+hoOmgX4lRlm3AcvamxPa8X
 KaHMZwZrYwuyvUwxxjdksFsysMt63c7QVhk0ZmExqrjD2A31jWQ4y52Twj5j5EEAF6w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791463489;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
 bh=qtj6r29uDOB1ISuFdxwEAe+i7VBUHss6K7rW1+T2I1I=;
 b=iBDtP4I9Fctle3SQMJcc25OgXUFXpT81mgcmbrEEmtAGkxqjfxer+e6DnGga8O6NpoBn
 XbP64O/tn6VTd62tbPSQ649MXf+Nerohhth0l8dPey96NrVG4HHS8jbF4uM8SeIcb+MWo
 WYxkPDOb05atqqz215l+g3ktkm/m4HId5q2h650vo4n46ANQw3w0cDPE6yyrNGpMSeolK
 55lLbxaQzBSx9jGD4q9Ksmpzz0HDxiGsDDskwQpO3BTie3yHO4lnygpOaX82EmETb97pf
 dl/8Vr2XCO8J1BFjMZTX3a9m07tmuLMjqppw3xI4FQBltPY15MIz1txIoGGKAhXPXgA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=FKNDhB5J; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=FKNDhB5J
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 92BBC606FF
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 12:44:48 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-48b0946c2c2so2125853f8f.3
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 05:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791463486; x=1792068286;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qtj6r29uDOB1ISuFdxwEAe+i7VBUHss6K7rW1+T2I1I=;
 b=FKNDhB5J7GQsBeQFlVXUYyFAA7s07f9p1Ntdiyz6Ld7dNgphi/cAabCZsW9zZEZAjm
 1WsPQ0tNnEY8zZQ/vFR1L5CxXzVoTnDUI/bvhMld0OvdSNQo0VH+wd6o81zohP2LrvbJ
 23ZaOf1faEuiixAJsr6ibrK6KbvTJUPoFn6YHrCNnmrlAF56zchp6oEExwMulg2Og5bq
 EdUL5DjURqJi7fctXjX0qq1GZKnHfNCO4BVAXdwMFTWRjNwU9/GxrlNYtuouie0H757x
 r3A1LIJ13hzeemOf2TzBRCMfItKzLhKKBwlF3dbkfE6GM+rWaKkG3KliZWAhiOUMsCHE
 Y/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791463486; x=1792068286;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qtj6r29uDOB1ISuFdxwEAe+i7VBUHss6K7rW1+T2I1I=;
 b=yNYVBXX2Jx1wZCzascFTk4Bus/bFZZXgWyQG/rtqm2cgwprLs16BK624H+zNnEO6lK
 npM9FL7w/VfLqyT611M+X6P/y83wOCX+ZTWaZtv4uZYgknrAtxXyyj3qOyILGlyR1SFn
 gaP55eT5tNrrE3rkMqo4vLqQsM806fnBuJ1pioA/UsVO5ehEVGzHP7yIJJhaYChQ9Hbc
 m1UPNxFUFpGv193I3rInF4p8pGa4vCtM1AnDjGX9JSV9eQzv9/oBtGHNdbz2avjgDTT1
 V8i7vTJpPK3mXQUpSCHGgr9aaf6Nu2sOJyFkxfV4HNUho6+3CDeYsuRqjSIN7jBBEP1k
 K3QA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx2kRrFV+dxyV01xTPQtmoRhVsMfsPUTO33onPA1WlTOIFqiZsPU03Lt3m2cwlvk9GABUIMfXs=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKC4ZsONhfM0NWwnPydv+06jMoghDjaX+eQZM5205LZJ8nRCN+h
 QDUr2oN3CIluwmzHIrD2mc1xW70PVbfy/RKOP/UwiAV4YkXNOyJ7nV9a2YKELvczFZXRfIgXlrn
 t11qYSNp0qA==
X-Gm-Gg: AYBFou24eIUU1DKwgU5C0cZq5qSK/GDS1XfsmZmiDQMg4ZyAwGj+VQezYniczuZOoTy
 sL7equFFjBHfdzi5MyV9md3LV2Gm36NFcGjqoXwb3xCwgUzeyzjrzaLjs5N7/E+U3OcC5VUQV5t
 jlV1UvQtal9pB2Fd4ryXnxQZNPfwnKVz5lI1aP/3BNuJJ/LdFq7QR/mo8lj62EEOnHJekjF7WQs
 SXfrdPJ+sUCBfp7/L173Oc9F4ubmk3lpnVPrrZpp1Q0sgEaullhl9Ydp/JugLE/8j3f338Uiod3
 u/XBjuGG+NPStBGoUkDgU2GjQ3qkFJKF7+YrvRbiNgUC5r5c6L6P6VBuVL6+r8jxLtCBp4cb4eL
 WwGj3E9mnNX3xmO3agM4SJyG67gkkdXFO0/Wgk8/foDXmnFpH/r5K8hxHBPlnr3bCC/q72TPysO
 qoz0K13z2NGgme98nxHfpbzrmWkq+rw8QX88nj4Bf9il/mibgnX7TB4G4VwaVqxRvnjxSZBAYE6
 uWyMiLM8EhSW/4QmuY=
X-Received: by 2002:a05:6000:4814:b0:48a:fb55:416c with SMTP id
 ffacd0b85a97d-48c72767815mr9855055f8f.21.1791463486003; 
 Thu, 08 Oct 2026 05:44:46 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c71d2eeb6sm11418650f8f.43.2026.10.08.05.44.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 05:44:45 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 Balaji Selvanathan via U-Boot <u-boot@lists.u-boot-project.org>
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Johan Jonker <jbx6244@gmail.com>, Luca Weiss <luca.weiss@fairphone.com>, 
 Biswapriyo Nath <nathbappai@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Lukasz Majewski <lukma@nabladev.com>
In-Reply-To: <20260812-b4-monaco-v2-0-865d288c0be6@oss.qualcomm.com>
References: <20260812-b4-monaco-v2-0-865d288c0be6@oss.qualcomm.com>
Subject: Re: [PATCH v2 0/7] qcom: qcs8300/monaco-evk: pinctrl,
 interconnect, RPMH clock and reboot-mode support
Message-Id: <179146348503.181743.8497947286515290533.b4-ty@b4>
Date: Thu, 08 Oct 2026 14:44:45 +0200
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

On Wed, 12 Aug 2026 06:41:58 +0530, Balaji Selvanathan via U-Boot wrote:
> This series brings up the Monaco (QCS8300) EVK target with a dedicated
> pinctrl driver, interconnect driver, a real sa8775p RPMH clock driver
> (replacing the generic clk-stub no-op), and PON/SDAM-backed reboot-mode
> support so "reboot bootloader" from Linux can be honored by U-Boot.
> qcom_qcs8300_defconfig is switched over to the monaco-evk device tree.
> 
> 
> [...]

Thanks, Applied to https://git.u-boot-project.org/u-boot/custodians/neil.armstrong/u-boot-ufs (main)

[1/7] clk: qcom: Add shared RPMH clock driver for SM8550/SM8650/SA8775P
      (no commit info)
[2/7] clk: qcom: qcs8300: Extend GCC clock driver to full gate/RCG coverage
      (no commit info)
[3/7] pinctrl: qcom: Add QCS8300 pinctrl driver
      (no commit info)
[4/7] interconnect: qcom: Add QCS8300 interconnect driver
      https://git.u-boot-project.org/u-boot/custodians/neil.armstrong/u-boot-ufs/-/commit/9db5fb79c2630e9b4fcb0d17dd8b5f383c783cfb
[5/7] arm64: dts: monaco-evk: Add reboot-mode support via PON/SDAM
      (no commit info)
[6/7] arm64: dts: monaco-evk: Force vreg_l8a always-on to protect UFS VCC
      (no commit info)
[7/7] configs: qcom_qcs8300: Switch to monaco-evk DT and enable new drivers
      (no commit info)

-- 
Neil

