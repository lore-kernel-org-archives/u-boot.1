Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A80C1C55ABF
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 21:26:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 61732607FC;
	Wed,  5 Aug 2026 21:26:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jgU-Hxz5KgcF; Wed,  5 Aug 2026 21:26:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0F093607EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785965194;
	bh=0r8oGZBGnGvcS3szKXvO65S86wMytbgBnzfqz2rBq8c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ot7tWexg5DVAq2nQIf6HFi7ArZUmhQnex5wiXUeQ67JSJt9HS1acbd+Ws1iosP2mz
	 a5bF4fcyVOA1UvMIoN61tUvUrkSxQdaWiHa1uRCagNGBkHT6s2k4uOX49QRPK/qquI
	 WU/Wt034bhYORLvIKt1bdB28a9tGvUFLacKrUCs9jq+G0jqivlnRUVGgcq1p0KdM7O
	 0e52ZiA7EYCYPCkz2UNhrxgeTiTkkH2iNPeZ4VWJ1YsExnvaw+NEtvx+WpNu3ukR+q
	 T8ASZ09zdOuLecSJDSElfg4XdtFw200f9TIlZqLrBTjg5PBqjP8SvTSrPT2gKQ3jMU
	 DpSgFwPk96Z+A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0F093607EC;
	Wed,  5 Aug 2026 21:26:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 82D57730
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 21:26:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 69C134023F
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 21:26:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8dL3e53-9mA2 for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 21:26:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::530; helo=mail-pg1-x530.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org CFEE940243
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CFEE940243
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CFEE940243
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 21:26:32 +0000 (UTC)
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-cbb7926836eso1111024a12.3
 for <u-boot@lists.u-boot-project.org>; Wed, 05 Aug 2026 14:26:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785965192; cv=none;
 d=google.com; s=arc-20260327;
 b=KvcLQIRuYHhzpXbdAWXGscbWHS1KGfDfH4XJdeBNZRLe2ylmW0Q7bFcODkhdUaoDQm
 K3p/zS82mu1vLgPOPjevfI3ZB1k6OiLyGb3ALoEK40BLTNnjKb6xrfHwlwIBe2xvDzmK
 N+qFyhwHBUZdXs2PjzeUi+sX2T45xe6AvhkWLEXbQ6W8r7WEsXUSxODUM+LPU56VvUBm
 0SseUkRmWqRt5h6ZQPrhjPxZyHCQDcZPuICFmsm3v82GpXxuQlpnUr1c/ASb+VQxt4Hl
 YisEwDntOJUmQuf8tit/xqe3jVRQFTmg+5JkcusCdcRROxlJ8y75qjd2KxSEpUFPPfEf
 90IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0r8oGZBGnGvcS3szKXvO65S86wMytbgBnzfqz2rBq8c=;
 fh=O9NPpGS9Qzf1GjYlU+fJx2+5H1A/E28dsQDIvZKqp4k=;
 b=ASzgMEKa6+Xrq88/3wDsdwy+UhcJ/P6ngHyQUsw2fKZX/m0hUZqd9XyLsTmpuxCxGE
 glQjZASEs0QS/HdlKIfOlpLaRnMwxibCe+9fcvqKS6geKo6DwT90sZIT5QQLhbdyi0he
 RRrhNr3COZn09EAKgxyfl+pO6HIVOg86pt7Ihe/EO0eaHdMoP2CZYAhBuNZcyZ9AJ3N0
 JFLH+lJoGvNRaNRqpdRQ/7zFCOahWlWwgDkJuFkg9v2oq4V3ehDj75Wto5Vz4E6DfWNo
 Ex5q7Fyphxv2LeMNBnEZpCLB/jsxZzizhRkkvTdtdWMN/wmZOokYWkVIA4Dzhd7Jhjyc
 zwRA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785965192; x=1786569992;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0r8oGZBGnGvcS3szKXvO65S86wMytbgBnzfqz2rBq8c=;
 b=fQqG1Yn1CfT2qE46WYGqKIHv5CAhXGMeMLYczIOOdZr9nGl36xfEp1pLzJC68NQ+fx
 HQNae7W7sb8LMdf5QAM9O1EHDjyEa7D3XQr/r386apeLfRLvfuRDP721ars1gFD/QDup
 cstzcxObyJtwRirb7O1J7+hs6XXE9QKL1CkWjXd0sDAkZgh1woEf0sUAa8CoHtXmZpM+
 o5CqUwMmAuFaZSu5HlnocReJhX2CTlfut/gnuPcvVKJxGMejlDI8xTS84z/EoaSFJrAk
 UgSRlFmJlzEd5esFPZrg8gsHGyF5LWa+YIfInkwbPuOJgFaIjuU3tUD/AaR8pCeSEbb7
 /UCw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp2ZdKho1yTsQkvwjVwAuo2OxhQzx2+foKm3/RjV6U4JFfUae/fI4g47ibl3bxpeYDdH0xRyCs=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwgpUbJaZzaqHDk0zx/l9bs2y4yvhoVY81po6q+NAEaXfdRQYf0
 rNjR1Jx4qjJIG3MoFjA6MwAzUyg9JfyFBdppqVQF8eKeFutOaUv7kiET4w5B1KTXPHHJPAPWkRL
 nXFO+IgWH6O+vYsxxmxJqSikSQFC7fAQcBnojDs2C
X-Gm-Gg: AR+sD12KClOuNBLVI3rHtj/H7ZLSiZsAN57UbaeB1Sr60pFGwknXtgGtajMPKOWpRGu
 Z7ilu+6kpXo4L0vOYzittwzG8Alj7gzcXLkt3uTb7lWWSz9BbkzGK2U1F9oMZmuJR7jWxFTZFVx
 ue6TR6TCsX6SiRl3MtFdB/r/6T7oIAJ+U3chs41lTGGMaRelVzTmiR8yn+YD+nt9eNEot60aCIA
 DGpf/iqG8J4Y5qJxlz2MJ0GkUTQ03XQk0ZLTi59Qq81JPAmE9hEFk78bm89Y0Vy/om/1d9YNrOt
 gF8bhuEXYbxw6OnNFqR6dZQYN2RSY0Z7YpARtvJq/4M=
X-Received: by 2002:a05:6a00:a116:b0:847:439b:ae30 with SMTP id
 d2e1a72fcca58-84f2e04b336mr10427424b3a.20.1785965192182; Wed, 05 Aug 2026
 14:26:32 -0700 (PDT)
MIME-Version: 1.0
References: <d15555b5-e57b-4567-ab70-56d48fd4b878@gmail.com>
 <ef6a25dd-f857-44c0-bd24-61d6377dd452@gmail.com>
In-Reply-To: <ef6a25dd-f857-44c0-bd24-61d6377dd452@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 5 Aug 2026 15:25:27 -0600
X-Gm-Features: AUfX_myAHEhe7Q45TdpOt_oahnJlUmx1Jzfi83aDFXD5L0rfQ4KkfmCCPIbbXcw
Message-ID: <CAFLszTg1Fk=NksnMbmka-LLOMuJzc1JZsjAHy0inp1CNBuPiGQ@mail.gmail.com>
Subject: Re: [PATCH v4 9/9] rockchip: doc: remove README.rockchip
To: jbx6244@gmail.com
Cc: u-boot@0leil.net, kever.yang@rock-chips.com, sjg@chromium.org, 
 trini@konsulko.com, u-boot@lists.u-boot-project.org, 
 eddie.cai.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785965192; x=1786569992;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0r8oGZBGnGvcS3szKXvO65S86wMytbgBnzfqz2rBq8c=;
 b=AHyjP0yxckbouVFCtuHL7x0AAKEGtmHHRgamkmBJIFiwJ4OI9dkEA4YRG6Jgu6xTTy
 D1oYU19fhzoylZ06LhuWSeyB8U4hudf4VIoPPGMRyjcUodIYW+uNcD/2Qwnug8f9kydg
 W83+uH/w8sMvQYhSS2HD8ua+Xg4Wa+1+pZu1M=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=AHyjP0yx
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

On 2026-08-03T19:09:22, Johan Jonker <jbx6244@gmail.com> wrote:
> rockchip: doc: remove README.rockchip
>
> Remove README.rockchip for info that's already in
> rockchip.rst or no longer applicable.
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>
> doc/README.rockchip | 677 ----------------------------------------------------
>  1 file changed, 677 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
