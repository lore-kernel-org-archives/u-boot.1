Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2DB0C47DAF
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 08:57:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF5CB87A9C;
	Thu, 18 Jan 2024 09:57:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="M/L0C23E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAA7E876C1; Thu, 18 Jan 2024 09:57:02 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B7FD87A9C
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 09:57:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-336746c7b6dso10217359f8f.0
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 00:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705568220; x=1706173020; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=NRkAzHt2zShRk/UrVqxmTLAQCSlVUoJru3lkIctJwXg=;
 b=M/L0C23E63/y4Ue/jNNQ/gYP2KKZ+QKqGNuxxjf6FEEMYAJ7aS1gtOGXqP/lR+GMLw
 H1qnMC5U2SeEQlOX8gt4589Fn223NcwiQ+e4Jf6V8AJooIhtnseqYG+nPfe3iuhUKgY+
 lTat6/7QnqmBxcfd+IQJKwtwpStQI7VhxyEtNaFCJu3lW/UXmeBY37TAu6qw3VXmOfgY
 vZ+su19OZUkW3hfXyT2kZrYqSys6n0z+25D/CfvgERt/Mxq2k6KLzASd6QXeJBBjmSIc
 ayN70LprUGn+40/ARqtIrmsl836vkMlv77CsY0Jf4ot0xxuqqhRMO705Gc4ms9IjiSgF
 r49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705568220; x=1706173020;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=NRkAzHt2zShRk/UrVqxmTLAQCSlVUoJru3lkIctJwXg=;
 b=SodNaNWaudDedUyAcitnSrL62A3OjL636lecmB+JNEC5Oh4jwMEOnLlKLAgEyXF/5o
 nlAmBVmQSHDQkyrMj02kCgfGy2tWY8ACAsSb8oek0W+JUBJLFLBqmEvt4qbiZ4pJVA2w
 UPP8+yc5EwQTSkxDh6Ui7n0vkv3nUnKPgR2umbroi8rKqutKfHnEEOaAYrxNWNTeMVc7
 3Tvp9e+UcvJBQn1HhbVFQib3HKFQU5dIZG85sUZ5YRf+G+UhE1SC6BOIDHjLCEzS98FT
 1zKDSOLHeMAPoENlJ0xcS19/SUrspFLctfOyouiuvlNZYH+ezLDUPkeRUgWUNoan6Aw+
 UdZQ==
X-Gm-Message-State: AOJu0YzK1zMZZztE9GRwqwl9HbOUs539D0tVt2qMlkWerLOUXSRmbYuO
 mSDKxt546bF7RhHYHVbC21mSnVZ5chyYje9GxJak7m1HUDYWcDkc38Y6Qr9QxLY=
X-Google-Smtp-Source: AGHT+IFEaxgQNLng9kz3yIrg+S4aY6kXOCk9YlpOZHxM329KNnpkA0uXTCQBsPfRNXP5+MN4I+u6iA==
X-Received: by 2002:adf:e9c1:0:b0:337:c4bc:a1df with SMTP id
 l1-20020adfe9c1000000b00337c4bca1dfmr260965wrn.107.1705568219634; 
 Thu, 18 Jan 2024 00:56:59 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:6ce5:dc98:50d7:a26a?
 ([2a01:e0a:982:cbb0:6ce5:dc98:50d7:a26a])
 by smtp.gmail.com with ESMTPSA id
 z2-20020adff1c2000000b003372b8ab19asm3515281wro.64.2024.01.18.00.56.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jan 2024 00:56:59 -0800 (PST)
Message-ID: <e19b68f5-acc5-4838-8fec-b0fb4b4f1a5e@linaro.org>
Date: Thu, 18 Jan 2024 09:56:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [UBOOT PATCH v4] test/py: net: Add dhcp abort test
Content-Language: en-US, fr
To: Love Kumar <love.kumar@amd.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
Cc: michal.simek@amd.com, git@xilinx.com, rfried.dev@gmail.com,
 v.v.mitrofanov@yadro.com, seanedmond@microsoft.com,
 emohandesi@linux.microsoft.com
References: <dd44fc9bf39e0debc9d0bc78a5d9215bace26023.1700571693.git.love.kumar@amd.com>
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro Developer Services
In-Reply-To: <dd44fc9bf39e0debc9d0bc78a5d9215bace26023.1700571693.git.love.kumar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Reply-To: neil.armstrong@linaro.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi,

On 21/11/2023 14:02, Love Kumar wrote:
> Abort the dhcp request in the middle by pressing ctrl + c on u-boot
> prompt and validate the abort status.
> 
> Signed-off-by: Love Kumar <love.kumar@amd.com>
> ---
> Changes in v2:
>   - Mark CMD_MII command dependency
> 
> Changes in v3:
>   - Skip the test if PHY device not present
> 
> Changes in v4:
>   - Setup the network configuration by running dhcp test at the end of
>   test
>   - Add option to skip the test if it is not desired or possible
> ---
>   test/py/tests/test_net.py | 57 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 57 insertions(+)
> 
> diff --git a/test/py/tests/test_net.py b/test/py/tests/test_net.py
> index b2241ae6a482..e0749125fd53 100644
> --- a/test/py/tests/test_net.py
> +++ b/test/py/tests/test_net.py
> @@ -7,6 +7,7 @@
>   import pytest
>   import u_boot_utils
>   import uuid
> +import re
>   
>   """
>   Note: This test relies on boardenv_* containing configuration values to define
> @@ -30,6 +31,11 @@ env__net_uses_pci = True
>   # set to False.
>   env__net_dhcp_server = True
>   
> +# False or omitted if a DHCP server is attached to the network, and dhcp abort
> +# case should be tested.
> +# If DHCP abort testing is not possible or desired, set this variable to True.
> +env__dhcp_abort_test_skip = True
> +
>   # True if a DHCPv6 server is attached to the network, and should be tested.
>   # If DHCPv6 testing is not possible or desired, this variable may be omitted or
>   # set to False.
> @@ -115,6 +121,57 @@ def test_net_dhcp(u_boot_console):
>       global net_set_up
>       net_set_up = True
>   
> +@pytest.mark.buildconfigspec("cmd_dhcp")
> +@pytest.mark.buildconfigspec("cmd_mii")
> +def test_net_dhcp_abort(u_boot_console):
> +    """Test the dhcp command by pressing ctrl+c in the middle of dhcp request
> +
> +    The boardenv_* file may be used to enable/disable this test; see the
> +    comment at the beginning of this file.
> +    """
> +
> +    test_dhcp = u_boot_console.config.env.get("env__net_dhcp_server", False)
> +    if not test_dhcp:
> +        pytest.skip("No DHCP server available")
> +
> +    if u_boot_console.config.env.get("env__dhcp_abort_test_skip", False):
> +        pytest.skip("DHCP abort test is not enabled!")
> +
> +    u_boot_console.run_command("setenv autoload no")
> +
> +    # Phy reset before running dhcp command
> +    output = u_boot_console.run_command("mii device")
> +    if not re.search(r"Current device: '(.+?)'", output):
> +        pytest.skip("PHY device does not exist!")
> +    eth_num = re.search(r"Current device: '(.+?)'", output).groups()[0]
> +    u_boot_console.run_command(f"mii device {eth_num}")
> +    output = u_boot_console.run_command("mii info")
> +    eth_addr = hex(int(re.search(r"PHY (.+?):", output).groups()[0], 16))
> +    u_boot_console.run_command(f"mii modify {eth_addr} 0 0x8000 0x8000")
> +
> +    u_boot_console.run_command("dhcp", wait_for_prompt=False)
> +    try:
> +        u_boot_console.wait_for("Waiting for PHY auto negotiation to complete")
> +    except:
> +        pytest.skip("Timeout waiting for PHY auto negotiation to complete")
> +
> +    u_boot_console.wait_for("done")
> +
> +    # Sending Ctrl-C
> +    output = u_boot_console.run_command(
> +        chr(3), wait_for_echo=False, send_nl=False
> +    )
> +
> +    assert "TIMEOUT" not in output
> +    assert "DHCP client bound to address " not in output
> +    assert "Abort" in output
> +
> +    # Provide a time to recover from Abort - if it is not performed
> +    # There is message like: ethernet@ff0e0000: No link.
> +    u_boot_console.run_command("sleep 1")
> +    # Run the dhcp test to setup the network configuration
> +    test_net_dhcp(u_boot_console)
> +
>   @pytest.mark.buildconfigspec('cmd_dhcp6')
>   def test_net_dhcp6(u_boot_console):
>       """Test the dhcp6 command.

This test fails on the BPI-M2S and BPI-M5 boards:

Section: test_net_dhcp_abort
TIME: NOW: 2024/01/18 08:43:48.152149
TIME: SINCE-PREV: 0:00:00.000629
TIME: SINCE-START: 0:02:17.928462
Stream: console
=> setenv autoload no
=>
End stream: console
TIME: NOW: 2024/01/18 08:43:48.232597
TIME: SINCE-PREV: 0:00:00.080448
TIME: SINCE-START: 0:02:18.008910
Stream: console
=> mii device
MII devices: 'mdio' 'mdio@0'
Current device: 'mdio'
=>
End stream: console
TIME: NOW: 2024/01/18 08:43:48.277449
TIME: SINCE-PREV: 0:00:00.044852
TIME: SINCE-START: 0:02:18.053762
Stream: console
=> mii device mdio
=>
End stream: console
TIME: NOW: 2024/01/18 08:43:48.318273
TIME: SINCE-PREV: 0:00:00.040824
TIME: SINCE-START: 0:02:18.094586
Stream: console
=> mii info
PHY 0x00: OUI = 0x0732, Model = 0x11, Rev = 0x06, 100baseT, FDX
PHY 0x01: OUI = 0x0732, Model = 0x11, Rev = 0x06, 100baseT, FDX
=>
End stream: console
TIME: NOW: 2024/01/18 08:43:48.370420
TIME: SINCE-PREV: 0:00:00.052147
TIME: SINCE-START: 0:02:18.146733
Stream: console
=> mii modify 0x0 0 0x8000 0x8000
=>
End stream: console
TIME: NOW: 2024/01/18 08:43:48.451550
TIME: SINCE-PREV: 0:00:00.081130
TIME: SINCE-START: 0:02:18.227863
Stream: console
=> dhcp
End stream: console
TIME: NOW: 2024/01/18 08:43:48.493680
TIME: SINCE-PREV: 0:00:00.042130
TIME: SINCE-START: 0:02:18.269993
Stream: console
ethernet@ff3f0000 Waiting for PHY auto negotiation to complete..... done
Speed: 100, full duplex
BOOTP broadcast 1
DHCP client bound to address 10.34.56.144 (3 ms)
=>
End stream: console
TIME: NOW: 2024/01/18 08:43:51.002287
TIME: SINCE-PREV: 0:00:02.508607
TIME: SINCE-START: 0:02:20.778600
Stream: console
=>
End stream: console
FAILED:
test/py/tests/test_net.py:171: in test_net_dhcp_abort
     assert "DHCP client bound to address " not in output
E   AssertionError: assert 'DHCP client... to address ' not in 'Speed: 100,...6.144 (3 ms)'
E     'DHCP client bound to address ' is contained here:
E       dcast 1
E
E       DHCP client bound to address 10.34.56.144 (3 ms)
TIME: SINCE-SECTION: 0:00:03.866916
End section: test_net_dhcp_abort

Full test logs:
Job https://gitlab.com/amlogic-foss/amlogic-u-boot-autotest/-/jobs/5956146503 :
https://amlogic-foss.gitlab.io/-/amlogic-u-boot-autotest/-/jobs/5956146503/artifacts/test-log.html
Job https://gitlab.com/amlogic-foss/amlogic-u-boot-autotest/-/jobs/5956097398 :
https://amlogic-foss.gitlab.io/-/amlogic-u-boot-autotest/-/jobs/5956097398/artifacts/test-log.html

It seems it makes DHCP fail on subsequent board reboots.

Neil
