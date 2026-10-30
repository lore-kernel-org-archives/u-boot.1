Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37297606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 17:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ObxZ6BBj;
	dkim=pass (2048-bit key, unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=CmiAcUk7
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1365481350;
	Fri, 30 Oct 2026 17:18:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jPF3CYOcCFVK; Fri, 30 Oct 2026 17:18:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2AA768130A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793380685;
	b=Zsx7yBmwatWhI+whS7TPCJlcuDF2dHAW8ZH0qVR/JZOKqg+mVjywE3iA6icyjKeqnZqc
	 VKfjDIx1tEBFuGEKDpoqxgFCoZpQeAeGPAtamB3bcpjS0aJ6vfj2fIegmkyvEaJXLBQph
	 vHecjVgwp29wDx1c/xZCm90f3H951VDf4+VrkV8n7eogMT/uGcnQ35cHvoUkRbCfzLsaW
	 t8J1/LZp2DkNzODF+1CDms+zCVcbbbke7KZXNIrzDv6F/7DvRt6GuNxDKCyOWeBaRpzAS
	 +O7lu2F5mbeV2xJCZgQnwRRCAcHoVKKtxP9HoBlIrojK2n4qt3uTw5vCAoFVHVB6X+Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793380685;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Infomaniak-Routing:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=IQ2RgkJBAP4WkOn+41I3SgTpY+IGkSU9HLTpoJWhb74=;
	b=K5/qmEWuwK/f+Sut8PWn0HFOSnaQEJ7yGqb6BKPy1MzOWD/b7iLGKHm8wej/lkkIJ2l2
	 4zKCRwy+OPqrzmv6krt+53uygSPEJTBFEC5ExHx5goWEwfw+n0WQJxHUM2gfpnNeoVKTf
	 w4v9Yh8uT1e37QOV7u3R5DAcMYID8ghlxZZY452sM921c0od2OMDWFF/wvWsovEXmQY8X
	 vWOharQwa4skYcdtW/p0+AnCDWkGweVbGrbwVRI/qYKYDUx6tLt+sS0s4e+CyHmHN3flF
	 woTh3VIzDDyUeLNKbXeF2hAoRcwvxFTqdMscxnHInPBMf4KhM/A0Nlk+Tt9Wo/wJkkA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=0leil.net;
	dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=CmiAcUk7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793380685;
	bh=IQ2RgkJBAP4WkOn+41I3SgTpY+IGkSU9HLTpoJWhb74=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ObxZ6BBjdtOEr57BmC/YmwRi1qVv3LradZrl105viQzz4xacmKYcOGC9X/6NxwxVJ
	 gor452KoSmEUvhzhAJkS4QGKbueeCK/co1JMwRXJvZlRhQvm7xRulF/8S0cDa2gy4R
	 sjPVIyBMn+2O61vA9rnrBvQ5PCNo3nvsQREDK5T7dMs9/BcAf/7ctDh+otBz6nZ+tN
	 t/+pG4OXv32SODRg0eHOSMyxO45ze4CBrN3a7uVBolf/1FMcqnWZW4S1tXkLGmBH0L
	 hjHtCRGalCjqf1T2Tfo7rzliz1r2oHoXnfrM3EDWnE3YA54WXACM9PODajOFI+L1JP
	 n75xOSjMdE1Jg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2AA768130A;
	Fri, 30 Oct 2026 17:18:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id DBBA5235
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 17:18:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C126D8132E
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 17:18:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iA5Q_-Y1Vlf3 for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 17:18:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1B2588130A
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:d548::42ad"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793380682;
 b=FDYuLOyp6l0/f6MOMP+59xzI9/8cS74XQpu1gujVflsM7FQKQSrl0QCNX339/OFEI1q6
 1FpkET8PpmoEm7/CcXSqFMuZlDppzeVBhXy8fW0CkOvXb9Du4dQ77XRfmA1lQq4Wim+rD
 bbpQK/Y733E7KwJ97fkeEqwlTYdX2Zq7SYiPovmRTY228aArf4fKoygpqZTNK4565894T
 eUL+3n2AaKu3OaAURoS6/i+UyvgLOC2Ej5GOP1MDdchsAVXntHHyqJzkyA5GD8+z05JBL
 DPlYjTCrbcpQJM+1lG2NqPwmbl72u6Gx7XywYlWUxnH1D0YQXR14cc+sNAPB6141zDA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793380682;
 h=Received-SPF:Received:DKIM-Signature:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer:X-Infomaniak-Routing;
 bh=IQ2RgkJBAP4WkOn+41I3SgTpY+IGkSU9HLTpoJWhb74=;
 b=h0grq20XGWfDLSdJE8i3diJ/JCFCoX2MNEvLg0W/ptt1GsfA9hhBg74TlnCXvPck1LCx
 z92ta0qZo+3359fACHvykdJtWSf61MZ27LCZWP4jSvPqccT8PfthDn3qmSPxPtahApgaC
 l1WKd32lK4ZZwuqjqXT/csLrRAOODJ+z5MhQUEhvwioL5+TBuLVYNoICHGpC7G+egyyzn
 ClOY7vc0LF8+yWSmW3eVwV8qOdBuh13LCw5NT1gHlhvZqPgVTjyDGxQ8fGaEl5C0TPFGI
 MfMffz2krNitz0VZ7xcF0NQ5iCoosvSPCIQ1bYggwEJyxHll4goaWsOtReQvN4l9i9w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=0leil.net;
 dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=CmiAcUk7; 
 arc=none smtp.remote-ip="2001:1600:19:d548::42ad"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:d548::42ad; helo=smtp-42ad.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=CmiAcUk7
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch
 [IPv6:2001:1600:19:d548::42ad])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1B2588130A
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 17:17:59 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jGSTw4qL7zBZj;
 Fri, 30 Oct 2026 18:17:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1793380676;
 bh=IQ2RgkJBAP4WkOn+41I3SgTpY+IGkSU9HLTpoJWhb74=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=CmiAcUk7uHjGl8YEoh9xuY8AvSmoFQj1gFqb+kxE+fD900U+je8cq3+ESbV0ECdZa
 7ojvD502DdQLszcgAZAOrxx5JVTMXvPJEsmDAXJqxT33QET94hG85e8bbhg/v6dRn5
 6dOyWkUlfUzwY388oPtNSnaV6lHI9VJ0YWLqtNXA2DWfBHiE2cXq9jUAsAu5qMotoo
 MXe8opa+5Z6cZxBc+9XbbMh3ShUm3QoFB8bXiIqom4RWU8GZ6LZpxGP16IUdrPwdf6
 3EXJUmRNNcEbyZ9HooAiONR2DxJUdSsAT5ulPZllxMRRmFfCfhkDhyNPUxVCD4Zm/L
 mE8h7Z5+hTdug==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jGSTv1JPQzb0l; Fri, 30 Oct 2026 18:17:55 +0100 (CET)
From: Quentin Schulz <u-boot@0leil.net>
To: u-boot@lists.u-boot-project.org, Dennis Gilmore <dennis@ausil.us>
Cc: Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Alexey Charkov <alchark@gmail.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Tom Rini <trini@konsulko.com>
In-Reply-To: <20261012020134.621305-1-dennis@ausil.us>
References: <20261012020134.621305-1-dennis@ausil.us>
Subject: Re: (subset) [PATCH v2 0/5] rockchip: Add Xunlong Orange Pi 5 Pro
Message-Id: <179338067511.786412.8753108177532759189.b4-ty@b4>
Date: Fri, 30 Oct 2026 18:17:55 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 11 Oct 2026 21:01:29 -0500, Dennis Gilmore wrote:
> This series adds support for the Xunlong Orange Pi 5 Pro, an RK3588S
> board with eMMC, an M.2 M-Key slot for NVMe and an onboard Motorcomm
> YT6801 1GbE NIC behind PCIe.
> 
> The board devicetree was merged for Linux v7.3. Patches 1-4 pick the
> required commits from devicetree-rebasing with
> tools/update-subtree.sh pick, so this series does not need to wait
> for the v7.3 dts sync. They include a refactor of the Orange Pi 5/5B
> devicetree that the Pro builds on.
> 
> [...]

Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip (u-boot-rockchip-2027.01), thanks!

[5/5] board: rockchip: Add Xunlong Orange Pi 5 Pro
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/57eb402cc8e5a951d251115b0b3bb6220806d42d

Best regards,
-- 
Quentin Schulz <u-boot@0leil.net>

